* *
* defining conditions for data generation VFP6 form select
* * *
SET SAFETY OFF
set talk off
clear memory
set deleted on

public type_p,type_name, type_adr, type_in,type_end; 
 type1, type2, type3, type4, type5,type6, type7, type8,type10;
 type11,type12,type13,type15,date_d

*Restoring the price list generation date
restore from date_prc.set additive
date_n=alltrim(str(sk_pc))
date_str=left(date_n,2)+'.'+substr(date_n,3,2)+'.'+right(date_n,2)
date_d=ctod(date_str)

*Error flag
error1=0

* Selecting the price list to be generated
do case
 case thisform.OptionGroup1.value=0
  MessageBox ("Out of type",27,"ERROR")
  error1=0
 case thisform.OptionGroup1.value=1
  type_p=1
  error1=100
 case thisform.OptionGroup1.value=2
  type_p=2
  error1=100
 case thisform.OptionGroup1.value=3
  type_p=3
  error1=100
endcase  

if empty(thisform.Combo1.value)
 MessageBox ("You have not specified the TYPE ",27,"ERROR")
 error1=0
endif 

*If all the initial data is provided, we generate a price list.
if error1>0
 do case
  case type_p=1
   SELECT * FROM NEW_PRC WHERE RAIT_G BETWEEN 999 AND 1499 ORDER BY RAIT_G , PRICENAME INTO DBF REPORT_T
     
  *ПРОЧЕЕ
  case type_p=2
   SELECT * FROM NEW_PRC WHERE RAIT_G BETWEEN 2000 AND 9999 ORDER BY RAIT_G , PRICENAME INTO DBF REPORT_T
    
  *МОРОЖЕНОЕ  
  case type_p=3   
   SELECT * FROM NEW_PRC WHERE RAIT_G BETWEEN 1500 AND 1999 ORDER BY RAIT_G , PRICENAME INTO DBF REPORT_T
 endcase 
 
  *Address, name, price list code, additional information for the buyer
  type_name=thisform.Combo1.value
  type_adr=thisform.text14.value  
  type_code=thisform.text15.value  
  type_in=thisform.edit1.value 
  *type_end
 
 *Formation of a price list for all products except ice cream
 if type_p<>3
 
  *%
  type1=thisform.text1.value  
  type2=thisform.text2.value  
  type3=thisform.text3.value  
  type4=thisform.text4.value  
  type5=thisform.text5.value  
  type6=thisform.text6.value  
  type7=thisform.text7.value  
  type8=thisform.text8.value  
 
  *Coefficient increase
  type10=thisform.text10.value  
  *Coefficient decrease
  type11=thisform.text11.value  
  *% min cost
  type12=thisform.text12.value     
  *Delivery
  type13=thisform.text13.value  
    
  *Possible error
  if(type_code<0)
    MessageBox ("There is an error in the program, please contact the developer",27,"ERROR !!!")
  endif
  
  *Price list by warehouse  -report_b-
  if (type_code=5 or type_code=6 or type_code=7)
   index on rait_g tag rait_g 
   report format report_b.frx preview for PRC_CODE="PR11" OR SDIR<>" "
  endif  
  
  *Pickup
  if type_code=1
     *Let's add calculation fields
     alter table REPORT_T add column new_c1 n(7,2)
     alter table REPORT_T add column new_c2 n(7,2)
     alter table REPORT_T add column new_c3 n(7,2)
     alter table REPORT_T add column new_c4 n(7,2)
     alter table REPORT_T add column new_c5 n(7,2)
   
     go 1
     do while !eof()
     cena=prc_val
     tmp     = (cena*type1)/100
     tmp1    = tmp - int( tmp )
     DO CASE
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) < 25
  	 	  tmp_ = round( tmp, 1 )
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) >= 25  .and.;
  	  		val( right( trans( tmp1, '9.999' ), 2 ) ) <  75             
  	    	tmp_ = int( tmp ) + val('0.' + substr( trans( tmp1, '9.999' ), 3, 1 ) ) + 0.05
  	  CASE  val( right( trans( tmp1, '9.999' ), 3 ) ) >= 75
  	 	  tmp_ = round( tmp, 1 )
      ENDCASE
      cena1 = tmp_
      cena_n=cena-cena1
      replace new_c1 with cena_n
      skip 1
    enddo
     go 1
     do while !eof()
     cena=prc_val
     tmp     = (cena*type2)/100
     tmp1    = tmp - int( tmp )
     DO CASE
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) < 25
  	 	  tmp_ = round( tmp, 1 )
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) >= 25  .and.;
  	  		val( right( trans( tmp1, '9.999' ), 2 ) ) <  75             
  	    	tmp_ = int( tmp ) + val('0.' + substr( trans( tmp1, '9.999' ), 3, 1 ) ) + 0.05
  	  CASE  val( right( trans( tmp1, '9.999' ), 3 ) ) >= 75
  	 	  tmp_ = round( tmp, 1 )
      ENDCASE
      cena1 = tmp_
      cena_n=cena-cena1
      replace new_c2 with cena_n
      skip 1
    enddo
    
    go 1
     do while !eof()
     cena=prc_val
     tmp     = (cena*type3)/100
     tmp1    = tmp - int( tmp )
     DO CASE
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) < 25
  	 	  tmp_ = round( tmp, 1 )
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) >= 25  .and.;
  	  		val( right( trans( tmp1, '9.999' ), 2 ) ) <  75             
  	    	tmp_ = int( tmp ) + val('0.' + substr( trans( tmp1, '9.999' ), 3, 1 ) ) + 0.05
  	  CASE  val( right( trans( tmp1, '9.999' ), 3 ) ) >= 75
  	 	  tmp_ = round( tmp, 1 )
      ENDCASE
      cena1 = tmp_
      cena_n=cena-cena1
      replace new_c3 with cena_n
      skip 1
    enddo
    
     go 1
     do while !eof()
     cena=prc_val
     tmp     = (cena*type4)/100
     tmp1    = tmp - int( tmp )
     DO CASE
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) < 25
  	 	  tmp_ = round( tmp, 1 )
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) >= 25  .and.;
  	  		val( right( trans( tmp1, '9.999' ), 2 ) ) <  75             
  	    	tmp_ = int( tmp ) + val('0.' + substr( trans( tmp1, '9.999' ), 3, 1 ) ) + 0.05
  	  CASE  val( right( trans( tmp1, '9.999' ), 3 ) ) >= 75
  	 	  tmp_ = round( tmp, 1 )
      ENDCASE
      cena1 = tmp_
      cena_n=cena-cena1
      replace new_c4 with cena_n
      skip 1
    enddo
    
    go 1
     do while !eof()
     cena=prc_val
     tmp     = (cena*type5)/100
     tmp1    = tmp - int( tmp )
     DO CASE
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) < 25
  	 	  tmp_ = round( tmp, 1 )
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) >= 25  .and.;
  	  		val( right( trans( tmp1, '9.999' ), 2 ) ) <  75             
  	    	tmp_ = int( tmp ) + val('0.' + substr( trans( tmp1, '9.999' ), 3, 1 ) ) + 0.05
  	  CASE  val( right( trans( tmp1, '9.999' ), 3 ) ) >= 75
  	 	  tmp_ = round( tmp, 1 )
      ENDCASE
      cena1 = tmp_
      cena_n=cena-cena1
      replace new_c5 with cena_n
      skip 1
    enddo
     go 1
     delete
     index on rait_g tag rait_g  
     report format report_s1.frx preview FOR PRC_CODE="PR11" OR SDIR<>" "
  endif
  
  *Delivery
  if type_code=2
   MessageBox (" Не готово ",27,"ОШИБКА")   
  endif
  
  *Delivery delay
  if type_code=3
     MessageBox (" Не готово ",27,"ОШИБКА") 
  endif
  
  *Shop  -report_m-
  if type_code=4
    *Добавим расчетное поле
    *alter table REPORT_T add column new_c1 n(7,2)
    alter table REPORT_T add column new_c1 n(7)
    *Расчет цены с процентом
     go 1
     do while !eof()
     cena=prc_val
     ?cena
     tmp     = (cena*type10)/100
     tmp1    = tmp - int( tmp )
     DO CASE
  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) < 25
  	 	  tmp_ = round( tmp, 1 )

  	  CASE  val( right( trans( tmp1, '9.999' ), 2 ) ) >= 25  .and.;
  	  		val( right( trans( tmp1, '9.999' ), 2 ) ) <  75             
  	    	tmp_ = int( tmp ) + val('0.' + substr( trans( tmp1, '9.999' ), 3, 1 ) ) + 0.05

  	  CASE  val( right( trans( tmp1, '9.999' ), 3 ) ) >= 75
  	 	  tmp_ = round( tmp, 1 )
      ENDCASE
      cena1 = tmp_
      cena_n=cena+cena1
      replace new_c1 with cena_n
      skip 1
    enddo
    go 1
    delete
    index on rait_g tag rait_g   
    report format report_m.frx preview for PRC_CODE="PR11" OR SDIR<>" " 
  endif
   
  *If a new price type is introduced, the parameters must be changed.
  if type_code>7
    MessageBox ("You have specified a price list TYPE that is not available in the program. ",27,"ERROR Product") 
  endif
  
  *If it's ice cream
  else
   *Самовывоз
   if type_code=1
      MessageBox (" Not Ready ",27,"ERROR")
  endif
  
  *Доставка
  if type_code=2
     MessageBox (" Not Ready ",27,"ERROR")
  endif
  
  *Магазин
  if type_code=4
    MessageBox (" Not Ready ",27,"ERROR")
  endif
   
    *Если будет введен новый вид прайса надо изменить параметры
  if type_code>7
    MessageBox ("You have specified a price list TYPE that is not available in the program. ",27,"ERROR ICE") 
  endif
  
  endif
  clear memory
endif
 
