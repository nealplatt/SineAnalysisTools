$i=0;

while(<>){
 
    ($contig[$i], $start[$i], $end[$i], $name[$i], $score[$i], $orient[$i]) = split;
   
    $i ++
}

$j=0;

while($j<=$#contig){
    
    if($contig[$j-1] eq $contig[$j]){
        $prev_start=$start[$j-1] - $start[$j];
    }else{
        $prev_start = undef;
    }

    if($contig[$j+1] eq $contig[$j]){
        $next_start=$start[$j+1] - $start[$j];
    }else{
        $next_start = undef;
    }



    if(abs($prev_start) <= abs($next_start)){
        $closest = $prev_start;
    }elsif(abs($next_start) <= abs($prev_start)){
        $closest = $next_start;
    }else{
        die "Error at line $j\n";
    }

    if($prev_start eq undef && $next_start eq undef){
        $closest = "na";
    }elsif($prev_start eq undef && $next_start ne undef){
        $closest = $next_start;
    }elsif($prev_start ne undef && $next_start eq undef){
        $closest = $prev_start;
    }
   
    $distr{$closest}++;

    #print "$contig[$j]\t$start[$j]\t$end[$j]\t$name[$j]\t$score[$j]\t$orient[$j]\t$closest\n";    

    $j++;

}

$window_pos = -1000;
$window_end = 1000;
while($window_pos <= $window_end){
    if($distr{$window_pos} eq undef){ $distr{$window_pos}=0; }
    print "$window_pos\t$distr{$window_pos}\n";
    $window_pos++;
}


