#! /usr/bin/perl

use LWP;
my $browser = LWP::UserAgent->new;
$baseurl = "http://gd2.mlb.com/components/game/mlb";
$outputdir = "./games";

use Time::Local;

sub extractDate($) {
    # extracts and formats date from a time stamp
    ($t) = @_;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
    = localtime($t);
    $mon  += 1;
    $year += 1900;
    $mon = (length($mon) == 1) ? "0$mon" : $mon;
    $mday = (length($mday) == 1) ? "0$mday" : $mday;
    return ($mon, $mday, $year);
}

sub verifyDir($) {
    # verifies that a directory exists,
    # creates the directory if the directory doesn't
    my ($d) = @_;
    if (-e $d) {
    die "$d not a directory\n" unless (-d $outputdir);
    } else {
    die "could not create $d: $!\n" unless (mkdir $d);
    }
}

sub getWithRetry($) {
    my ($arg) = @_;
    my ($fileurl) = $arg;
#   print "\t\t\tGET : $fileurl\n";
    my ($response) = $browser->get($fileurl);
    unless ($response->is_success) {
        $fileurl = $arg;
        print "RETRY\t\t\tGET : $fileurl\n";
        $response = $browser->get($fileurl);
    }
    unless ($response->is_success) {
        $fileurl = $arg;
        print "RETRY\t\t\tGET : $fileurl\n";
        $response = $browser->get($fileurl);
    }
    unless ($response->is_success) {
        die "FAIL\t\t\tGET : $fileurl\n", $response->status_line, "\n"
    }

    return ($response);
}

# get all important files from MLB.com, 4/2/07 through yesterday
# 0,0,0,day,month+1,1900+year
$start = timelocal(0,0,0,22,2,114);
($mon, $mday, $year) = extractDate($start);
print "starting at $mon/$mday/$year\n";

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
#$now = timelocal(0,0,0,$mday - 0,$mon,$year);
#$now = timelocal(0,0,0,$mday - 1,$mon,$year);
$now = timelocal(0,0,0,29,9,114);
($mon, $mday, $year) = extractDate($now);
print "ending at $mon/$mday/$year\n";

verifyDir($outputdir);

for ($t = $start; $t < $now; $t += 60*60*24) {
    ($mon, $mday, $year) = extractDate($t);
    print "processing $mon/$mday/$year\n";

    verifyDir("$outputdir/year_$year");
    verifyDir("$outputdir/year_$year/month_$mon");
    verifyDir("$outputdir/year_$year/month_$mon/day_$mday");

    $dayurl = "$baseurl/year_$year/month_$mon/day_$mday/";
    print "\t$dayurl\n";

    $response = getWithRetry($dayurl);
    $html = $response->content;
    my @games = ();
    while($html =~ m/<a href=\"(gid_\w+\/)\"/g ) {
#    while($html =~ m/<a href=\"(gid_\w+_(sur|per|pes|afe|afw)win_1\/)\"/g) {
#    while($html =~ m/<a href=\"(gid_\w+_(kca|tex|sdn|sea)\/)\"/g ) {
        push @games, $1;
    }

    foreach $game (@games) {
    $gamedir = "$outputdir/year_$year/month_$mon/day_$mday/$game";
    if (-e $gamedir) {
        # already fetched info on this game
        print "\t\tskipping game: $game\n";
    } else {
        print "\t\tfetching game: $game\n";
        verifyDir($gamedir);
        $gameurl = "$dayurl/$game";
        $response = getWithRetry($gameurl);
        $gamehtml = $response->content;

        if($gamehtml =~ m/<a href=\"boxscore\.xml\"/ ) {
        $boxurl = "$dayurl/$game/boxscore.xml";
        $response = getWithRetry($boxurl);
        $boxhtml = $response->content;
        open BOX, ">$gamedir/boxscore.xml"
            or die "could not open file $gamedir/boxscore.xml: $|\n";
        print BOX $boxhtml;
        close BOX;
        } else {
        print "warning: no xml box score for $game\n";
        }

        if($gamehtml =~ m/<a href=\"game\.xml\"/ ) {
        $gameurl = "$dayurl/$game/game.xml";
        $response = getWithRetry($gameurl);
        $infohtml = $response->content;
        open GAME, ">$gamedir/game.xml"
            or die "could not open file $gamedir/game.xml: $|\n";
        print GAME $infohtml;
        close GAME;
        } else {
        print "warning: no xml game file for $game\n";
        }

        if($gamehtml =~ m/<a href=\"players\.xml\"/ ) {
        $plyrurl = "$dayurl/$game/players.xml";
        $response = getWithRetry($plyrurl);
        $plyrhtml = $response->content;
        open PLYRS, ">$gamedir/players.xml"
            or die "could not open file $gamedir/players.xml: $|\n";
        print PLYRS $plyrhtml;
        close PLYRS;
        } else {
        print "warning: no player list for $game\n";
        }


        if($gamehtml =~ m/<a href=\"inning\/\"/ ) {
        $inningdir = "$gamedir/inning";
        verifyDir($inningdir);
        $inningurl = "$dayurl/$game/inning/";
        $response = getWithRetry($inningurl);
        $inninghtml = $response->content;

        my @files = ();
        while($inninghtml =~ m/<a href=\"(inning_.*)\"/g ) {
            push @files, $1;
        }

        foreach $file (@files) {
            print "\t\t\tinning file: $file\n";
            $fileurl = "$inningurl/$file";
            $response = getWithRetry($fileurl);
            $filehtml = $response->content;
            open FILE, ">$inningdir/$file"
            or die "could not open file $inningdir/$file: $|\n";
            print FILE $filehtml;
            close FILE;
        }
        }
        sleep(1); # be at least somewhat polite; one game per second
    }
    }
}
