use strict;
use warnings;

## Add your preference file for chrome, add the URL's you want in the @urls array (you can add more than just 2), close chrome and run... Enjoy


my $pref_file = 'chrome_preferences_file';

my @urls = ('URL1','URL2');

my $insert =',"pinned_tabs":[';

for my $i (@urls) {
	if(  \$i == \$urls[-1]  ) {
		$insert .= '{"url":"' . $i . '"}],';
	} else {
		$insert .= '{"url":"' . $i . '"},';
	}
}

my $ignore = ',"pinned_tabs":\[\{"url":';

my $find = ',\"pinned_tabs\":\[],';

open (my $fh, "<", "$pref_file") or die "Could not open file '$pref_file' $!";

my $file = <$fh>; 

close $fh;

if ($file =~ m/$ignore/) {
	die "Pinned tab entry already exists";
}

open ($fh, ">", "$pref_file") or die "Could not open file '$pref_file' $!";

$file =~ s/$find/$insert/;

print $fh "$file";

close $fh;

print "Pinned tab entry modified- \n Found: $find \n Replaced with: $insert";
