$i=0;

$big_windows = 0;
while(<>){
 
    ($contig[$i], $start[$i], $end[$i], $score[$i], $orient[$i]) = split;
   
    $i ++
}

$j=0;

while($j<=$#contig){
    
    #identify non-continuous reads (those that are seperated by gt 1 nuc)

    #if reads are on two seperate contigs then they are not contiguous
    if($contig[$j] ne $contig[$j+1]){

        print "$contig[$j]\t$start[$j]\t$end[$j]\t$score[$j]\t$orient[$j]\t$score[$j]\n";
         
    #if read oriented in different directions they are not contiguous
    }elsif($orient[$j] ne $orient[$j+1]){
   
       print "$contig[$j]\t$start[$j]\t$end[$j]\t$score[$j]\t$orient[$j]\t$score[$j]\n";

    #if the two start positions are seperated by more than 1 bp they are not contiguous
    }elsif( abs($start[$j] - $start[$j+1]) > 1){
        
       print "$contig[$j]\t$start[$j]\t$end[$j]\t$score[$j]\t$orient[$j]\t$score[$j]\n";
    
    #if the start sites are within 1 bp ------process further
    }elsif( abs($start[$j] - $start[$j+1]) == 1){
        
        $n=1;
        $window_start = $j;
        $bestScore = $score[$j];
        $expected_real_read = $j;
        $cuml_score = $score[$j];

      

        #descends down the array to find the end of the continous nucleotids
        while( (abs($start[$j] - $start[$j+$n]) == 1) or  (abs($start[$j+$n] - $start[$j+$n-1])== 1)) {
            
            
            #keep track of the end of the window
            $window_end = ($j+$n);
           
            #find the position with the most reads mapping
            if($bestScore < $score[$j+$n]){
                $bestScore = $score[$j+$n];
                $expected_real_read = $j+$n;
      
                
            }

            $cuml_score+=$score[$j+$n];
                    
            $n++;
        }#closes while loop descending into the array;

        
            print "$contig[$expected_real_read]\t$start[$expected_real_read]\t$end[$expected_real_read]\t$score[$expected_real_read]\t$orient[$expected_real_read]\t$cuml_score\n"; 


            



            $j=$window_end;
        
            if($window_end - $window_start > 10){
                warn "There is an excedingly large window from lines $window_start to $window_end\n";
            }

    }else{
        die "**************somethign is going on that hasn't been accounted for at line********** [$j]\n";
        #$big_windows++;
    }

    $j++;

}#closes while loop (through array)


