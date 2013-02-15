#!/usr/bin/env perl
use File::Copy;
my $action = $ARGV[0];
my $volume = $ARGV[1];
my $username = $ARGV[2];
my $timeData = join('_', localtime(time));

my $local_dotm = "/Users/" . $username . "/Library/Application Support/Microsoft/Office/Benutzervorlagen/Normal.dotm";
my $gibbix_dotm = $volume . "/Normal.dotm";

if($action eq "Auf Gibbix kopieren") {
	
	mkdir $volume . "/_Normal_Backup", 0777 unless -d $volume . "/_Normal_Backup";

	my $backup_destination = $volume . "/_Normal_Backup/Normal_" . $timeData . ".dotm";

	#First make a backup, then copy Normal.dotm to destination

	copy($gibbix_dotm, $backup_destination) or die "Copy failed";
	copy($local_dotm, $gibbix_dotm) or die "Copy failed";

	print "Succesful copied!\n";

} elsif($action eq "Auf Mac kopieren") {

	mkdir "/Users/" . $username . "/Library/Application Support/Microsoft/Office/Benutzervorlagen/_Normal_Backup", 0777 unless -d "/Users/" . $username . "/Library/Application Support/Microsoft/Office/Benutzervorlagen/_Normal_Backup";

	my $backup_destination = "/Users/" . $username . "/Library/Application Support/Microsoft/Office/Benutzervorlagen/_Normal_Backup/Normal_" . $timeData . ".dotm";
	#First make a backup, then copy Normal.dotm to destination

	copy($local_dotm, $backup_destination) or die "Copy failed";
	copy($gibbix_dotm, $local_dotm) or die "Copy failed";

	print "Succesful copied!\n";

} else {
	print "Wrong argument passed! Normal.dotm has not been copied!\nAction: $action \nVolume $volume\n";
}
