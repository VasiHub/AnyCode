#Array System 2 -> 6 step by step
def arr_change6(arr):
 new_arr = []
 for i_bin in arr:
    dec_num = int(i_bin, 2)
    print("  2  ->  10   : ", i_bin,"  ->  ", dec_num) # del
    four_num = ""
    while dec_num > 0:
        four_num = str(dec_num % 6) + four_num
        print("10   -    remainder from division : ", dec_num, " /6 ", four_num) # del
        dec_num //= 6
        print("* dec_num : ", dec_num) # del
    new_arr.append(four_num)
    print("# Exit 6 : ", four_num)  # del
 return new_arr    
    
bin_arr= [bin(354), bin(72), bin(109), bin(42),bin(217)] # 2 as 10
#bin_arr= ['0b101100010', '0b1001000', '0b1101101', '0b101010', '0b11011001'] # 2 system
   
print("The original array of real numbers in the 2 system:", bin_arr)    
print("The final array in the 6 system:", arr_change6(bin_arr))