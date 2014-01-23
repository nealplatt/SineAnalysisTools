$line = 1;
while(<>){
    ($contig, $start, $end, $name, $score, $orient) = split;
    if($orient eq "+"){
        $ves_start=$start-1;
    }elsif($orient eq "-"){
        $ves_start=$start+1;
    }else{ 
        die "problem at line# $line\n";
    }

	if($ves_start < 0){ $ves_start = 0; }

    $ves_end = $ves_start+1;
    print "$contig\t$ves_start\t$ves_end\t$name\t$score\t$orient\n";  
    $line++
}
