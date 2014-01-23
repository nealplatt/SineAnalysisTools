while($distance = <>){
	chomp $distance;    
#	print "$distance\n";
	$distance_histogram{$distance}++;
}


$distance_num = -100;
$end = 100;

while($distance_num <= $end){
	if($distance_histogram{$distance_num} eq undef){ $distance_histogram{$distance_num} = 0;} 
    print "$distance_num\t$distance_histogram{$distance_num}\n";
    $distance_num++;
}
