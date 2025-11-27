# Product of negative array elements.
# Sum of positive elements up to the maximum.
# Reverse order.

def pro_neg_elem(in_arr): # Func - Product of negative array elements.
    pro=1 
    el=0 
    for i in range(n): 
         if in_arr[i]<0:
          pro=pro*in_arr[i] 
          el+=el
    if el==0: return "There are no negative elements in the array !"       
    return pro 

def sum_max_elem(in_arr): # Func - Sum of positive elements up to the maximum.
 sum_max = 0  
 max_idx = in_arr.index(max(in_arr)) 
 for i in range(0, max_idx): 
    sum_max += in_arr[i] 
 return sum_max  

def arr_sorted(in_arr): # Func - Reverse order.
 revers = [] 
 for i in range(len(in_arr) - 1, -1, -1): 
   revers.append(in_arr[i]) 
 return revers  

n=int(input("Entering the number of array elements, N= "))
my_array = []
for i in range(n): 
    num = int(input(f"Enter an integer array element, index {i} : "))
    my_array.append(num)  

print("Source array:", my_array) 
print("Product of negative array elements : ", pro_neg_elem(my_array))
print("Sum of positive elements up to the maximum : ", sum_max_elem(my_array))
print("ransformed array of elements : ", arr_sorted(my_array))