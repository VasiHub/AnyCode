# Input array with floating point 10 -> 2 system
def dec_to_bin(in_arr): 
    new_arr = [] 
    for num in in_arr: 
       
        befor_point = int(num)
        after_point = num - befor_point

        bin_int = bin(befor_point).replace("0b", "")                                                    
        bin_fr = [] 
        while after_point > 0 and len(bin_fr) < 10:                                                      
              after_point *= 2 
              bit = int(after_point) 
              bin_fr.append(str(bit)) 
              after_point -= bit                                  
        
        new_num = bin_int + "." + "".join(bin_fr) if bin_fr else bin_int      
        new_arr.append(new_num) 
                                       
    return new_arr  


n=int(input("Enter the number of array elements, N= "))
if n <= 0: 
   print("The number must be natural!") 
else: 
  my_array = [] 
  for i in range(n): 
    num = float(input(f"Enter a real array element with an index {i} : ")) 
    my_array.append(num) 


print("\nThe original array of real numbers in the 10th system: ", my_array)
print("The final array in the 2nd system:", dec_to_bin(my_array))
