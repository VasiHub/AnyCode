set talk off
set deleted off
set exclusive off
set date german
set safety off
set default to C:\PRICE\DBF

*Network path
path_='y:\data\fct_stl\dbf\'
pathgoods=path_+'goods.dbf'
pathprice=path_+'price.dbf'
pathavail=path_+'avail.dbf'
close database

*Copy the product name
use (pathgoods)
copy to c:\price\dbf\goods.dbf for pricename<>" " .and. sdir=" " .and. price=.t.

*Copy the product price
use (pathprice)
copy to c:\price\dbf\price.dbf
close database

*Copying product availability
use (pathavail)
copy to c:\price\dbf\avail.dbf
close database

*Merging files goods & price
use c:\price\dbf\goods.dbf new
use c:\price\dbf\price.dbf new
 join with goods to new_prc;
 for price->unival=goods->partcode;
  fields goods->rait_g, goods->raiting, goods->pricename, goods->unit, goods->inbox, goods->sdir, goods->wes, goods->show_prc, prc_code, prc_val
close database

*Let's add product catalogs
use new_prc.dbf new
append from(pathgoods) fields pricename,rait_g,show_prc,raiting,sdir;
 for sdir<>" " .and. pricename<>" " .and. rait_g<>0 .and. show_prc=.T.
close database