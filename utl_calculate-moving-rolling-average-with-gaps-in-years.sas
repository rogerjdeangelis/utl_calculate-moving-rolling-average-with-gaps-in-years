Calculate moving rolling average with gaps in years                                                                       
                                                                                                                          
   Three R Solutions                                                                                                      
                                                                                                                          
       a. rollmean function                                                                                               
                                                                                                                          
       b. rolling window                                                                                                  
          windows must have at least 3 observations                                                                       
          slightly different output;                                                                                      
          https://github.com/andrewuhl/RollingWindow                                                                      
                                                                                                                          
       c. One liner by                                                                                                    
          Keintz, Mark                                                                                                    
          mkeintz@wharton.upenn.edu                                                                                       
                                                                                                                          
          Longer windows possible by adding lags                                                                          
          Automatically takes care of non sequencial sequences within ID and changes in UD                                
          Should be very fast                                                                                             
                                                                                                                          
       d. Interesting MA where missing consecutive 3 days are always set to missing and                                   
          other gaps are filled (see detal explanantion below.                                                            
          John Whittington                                                                                                
          John.W@mediscience.co.uk                                                                                        
                                                                                                                          
       e. array                                                                                                           
          Bartosz Jablonski                                                                                               
          yabwon@gmail.com                                                                                                
                                                                                                                          
                                                                                                                          
How to install rolling window;                                                                                            
                                                                                                                          
# install.packages("devtools") # if not installed                                                                         
                                                                                                                          
library(devtools)                                                                                                         
install_github("andrewuhl/RollingWindow")                                                                                 
                                                                                                                          
github                                                                                                                    
https://tinyurl.com/y3dukh6n                                                                                              
https://github.com/rogerjdeangelis/utl_calculate-moving-rolling-average-with-gaps-in-years                                
                                                                                                                          
related repos                                                                                                             
https://tinyurl.com/y3wohee8                                                                                              
https://github.com/rogerjdeangelis?tab=repositories&q=moving++in%3Aname&type=&language=                                   
https://github.com/rogerjdeangelis?tab=repositories&q=rolling++in%3Aname&type=&language=                                  
                                                                                                                          
SAS Forum                                                                                                                 
https://tinyurl.com/y67nzhkl                                                                                              
https://communities.sas.com/t5/SAS-Programming/How-to-calculate-moving-average-with-gaps-in-years/m-p/677977              
                                                                                                                          
/*                   _                                                                                                    
(_)_ __  _ __  _   _| |_                                                                                                  
| | `_ \| `_ \| | | | __|                                                                                                 
| | | | | |_) | |_| | |_                                                                                                  
|_|_| |_| .__/ \__,_|\__|                                                                                                 
        |_|                                                                                                               
*/                                                                                                                        
options validvarname=upcase;                                                                                              
libname sd1 "d:/sd1";                                                                                                     
data sd1.have;                                                                                                            
   input id year variable;                                                                                                
cards4;                                                                                                                   
1 1990 0.24                                                                                                               
2 2003 0.13                                                                                                               
2 2004 0.22                                                                                                               
2 2005 0.26                                                                                                               
2 2006 0.1                                                                                                                
2 2007 0.95                                                                                                               
5 1998 0.2                                                                                                                
5 1999 0.33                                                                                                               
5 2000 0.42                                                                                                               
5 2001 0.01                                                                                                               
5 2002 0.42                                                                                                               
5 2004 0.54                                                                                                               
5 2005 0.83                                                                                                               
5 2006 0.13                                                                                                               
5 2007 0.25                                                                                                               
5 2011 0.98                                                                                                               
5 2012 0.4                                                                                                                
5 2013 0.75                                                                                                               
5 2014 0.08                                                                                                               
5 2015 0.09                                                                                                               
5 2016 0.32                                                                                                               
5 2018 0.15                                                                                                               
5 2019 0.86                                                                                                               
;;;;                                                                                                                      
run;quit;                                                                                                                 
                                                                                                                          
/*           _               _                                                                                            
  ___  _   _| |_ _ __  _   _| |_                                                                                          
 / _ \| | | | __| `_ \| | | | __|                                                                                         
| (_) | |_| | |_| |_) | |_| | |_                                                                                          
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                         
                |_|                                                                                                       
*/                                                                                                                        
                                                                                                                          
ROLLING 3 YEAR MEAN                                                                                                       
                                                                                                                          
NOTE: A new grouping variable is created whenever the years are not sequential.                                           
                                                                                                                          
Up to 40 obs WORK.WANT total obs=23                                                                                       
                                                                                                                          
  YEAR    VARIABLE ID     GRP    ROL3MEAN                                                                                 
                                                                                                                          
  1990      0.24    1      2       .                                                                                      
                                                                                                                          
  2003      0.13    2      3       .                                                                                      
  2004      0.22    2      3       .                                                                                      
  2005      0.26    2      3      0.20333                                                                                 
  2006      0.10    2      3      0.19333                                                                                 
  2007      0.95    2      3      0.43667                                                                                 
                                                                                                                          
  1998      0.20    5      4       .                                                                                      
  1999      0.33    5      4       .                                                                                      
  2000      0.42    5      4      0.31667                                                                                 
  2001      0.01    5      4      0.25333                                                                                 
  2002      0.42    5      4      0.28333                                                                                 
                                                                                                                          
  2004      0.54    5      5       .       Note because 2003 is missing we create a new group                             
  2005      0.83    5      5       .                                                                                      
  2006      0.13    5      5      0.50000                                                                                 
  2007      0.25    5      5      0.40333                                                                                 
                                                                                                                          
  2011      0.98    5      6       .                                                                                      
  2012      0.40    5      6       .                                                                                      
  2013      0.75    5      6      0.71000                                                                                 
  2014      0.08    5      6      0.41000                                                                                 
  2015      0.09    5      6      0.30667                                                                                 
  2016      0.32    5      6      0.16333                                                                                 
                                                                                                                          
  2018      0.15    5      7       .                                                                                      
  2019      0.86    5      7       .                                                                                      
                                                                                                                          
/*   _     _   _                               _                                                                          
  __| |   | |_| |__  _ __ ___  ___   _ __ ___ (_)___ ___                                                                  
 / _` |   | __| `_ \| `__/ _ \/ _ \ | `_ ` _ \| / __/ __|                                                                 
| (_| |_  | |_| | | | | |  __/  __/ | | | | | | \__ \__ \                                                                 
 \__,_(_)  \__|_| |_|_|  \___|\___| |_| |_| |_|_|___/___/                                                                 
                                                                                                                          
*/                                                                                                                        
 Interesting enhancement                                                                                                  
                                                                                                                          
Up to 40 obs WORK.WANT total obs=28                                                                                       
                                                                                                                          
                                       ROLLING_                                                                           
Obs    ID    YEAR    VARIABLE            MEAN                                                                             
                                                                                                                          
  1     1    1990      0.24             0.24000                                                                           
  2     2    2003      0.13             0.18500                                                                           
  3     2    2004      0.22             0.19667                                                                           
  4     2    2005      0.26             0.20333                                                                           
  5     2    2006      0.10             0.19333                                                                           
  6     2    2007      0.95             0.43667                                                                           
  7     5    1998      0.20             0.41667                                                                           
  8     5    1999      0.33             0.49333                                                                           
  9     5    2000      0.42             0.31667                                                                           
 10     5    2001      0.01             0.25333                                                                           
 11     5    2002      0.42             0.28333                                                                           
 12     5    2003       .               0.21500                                                                           
 13     5    2004      0.54             0.48000                                                                           
 14     5    2005      0.83             0.68500                                                                           
 15     5    2006      0.13             0.50000                                                                           
 16     5    2007      0.25             0.40333                                                                           
 17     5    2008       .   * sequence  0.19000                                                                           
 18     5    2009       .     three     0.25000                                                                           
 19     5    2010       .     missing    .       * fined because parking meter                                            
 20     5    2011      0.98             0.98000    ran out after 3 periods                                                
 21     5    2012      0.40             0.69000                                                                           
 22     5    2013      0.75             0.71000                                                                           
 23     5    2014      0.08             0.41000                                                                           
 24     5    2015      0.09             0.30667                                                                           
 25     5    2016      0.32             0.16333                                                                           
 26     5    2017       .               0.20500                                                                           
 27     5    2018      0.15             0.23500                                                                           
 28     5    2019      0.86             0.50500                                                                           
                                                                                                                          
/*         _       _   _                                                                                                  
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                                  
/ __|/ _ \| | | | | __| |/ _ \| `_ \/ __|                                                                                 
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                                 
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                                 
                     _ _                                                                                                  
  __ _     _ __ ___ | | |_ __ ___   ___  __ _ _ __                                                                        
 / _` |   | `__/ _ \| | | `_ ` _ \ / _ \/ _` | `_ \                                                                       
| (_| |_  | | | (_) | | | | | | | |  __/ (_| | | | |                                                                      
 \__,_(_) |_|  \___/|_|_|_| |_| |_|\___|\__,_|_| |_|                                                                      
                                                                                                                          
*/                                                                                                                        
                                                                                                                          
%utlfkil(d:/xpt/want.xpt);                                                                                                
                                                                                                                          
* create a new id within a id if yeears are not sequential;                                                               
data sd1.havGrp(keep=grp variable);                                                                                       
  retain grp 1;                                                                                                           
  set have;                                                                                                               
  by id;                                                                                                                  
  difid=dif(year);                                                                                                        
  if first.id or (first.id + last.id = 0 and difid ne 1) then  grp=grp + 1;                                               
run;quit;                                                                                                                 
                                                                                                                          
%utl_submit_r64('                                                                                                         
library(haven);                                                                                                           
library(dplyr);                                                                                                           
library(tidyr);                                                                                                           
library(zoo);                                                                                                             
library(SASxport);                                                                                                        
library(lubridate);                                                                                                       
have<-read_sas("d:/sd1/havgrp.sas7bdat");                                                                                 
have;                                                                                                                     
myfun = function(x) rollmean(x, k = 3, fill = NA, align = "right");                                                       
have %>%                                                                                                                  
   group_by(GRP) %>%                                                                                                      
   mutate_each(funs(myfun), VARIABLE)                                                                                     
   -> want;                                                                                                               
want<-as.data.frame(want);                                                                                                
write.xport(want,file="d:/xpt/want.xpt");                                                                                 
');                                                                                                                       
                                                                                                                          
libname xpt xport "d:/xpt/want.xpt";                                                                                      
data want ;                                                                                                               
  merge have(keep=id year variable) xpt.want(rename=variable=rol3mean);                                                   
run;quit;                                                                                                                 
libname xpt clear;                                                                                                        
                                                                                                                          
/*                  _ _            _           _                                                                          
| |__     _ __ ___ | | | __      _(_)_ __   __| | _____      __                                                           
| `_ \   | `__/ _ \| | | \ \ /\ / / | `_ \ / _` |/ _ \ \ /\ / /                                                           
| |_) |  | | | (_) | | |  \ V  V /| | | | | (_| | (_) \ V  V /                                                            
|_.__(_) |_|  \___/|_|_|   \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/                                                             
                                                                                                                          
*/                                                                                                                        
                                                                                                                          
* windows must have at least 3 observations;                                                                              
                                                                                                                          
%utlfkil(d:/xpt/want.xpt);                                                                                                
                                                                                                                          
* create a new id within a id if yeears are not sequential;                                                               
data sd1.havGrp(keep=id grp year variable);                                                                               
  retain grp 1;                                                                                                           
  set have(firstobs=2 obs=21);                                                                                            
  by id;                                                                                                                  
  difid=dif(year);                                                                                                        
  if first.id or (first.id + last.id = 0 and difid ne 1) then  grp=grp + 1;                                               
run;quit;                                                                                                                 
                                                                                                                          
%utl_submit_r64('                                                                                                         
library(haven);                                                                                                           
library(dplyr);                                                                                                           
library(data.table);                                                                                                      
library(RollingWindow);                                                                                                   
library(SASxport);                                                                                                        
have<-as.data.table(read_sas("d:/sd1/havgrp.sas7bdat"));                                                                  
have[,want := RollingMean(VARIABLE,window = 3), by=GRP];                                                                  
have;                                                                                                                     
str(have);                                                                                                                
write.xport(have,file="d:/xpt/want.xpt");                                                                                 
');                                                                                                                       
                                                                                                                          
libname xpt xport "d:/xpt/want.xpt";                                                                                      
data want ;                                                                                                               
  merge have(keep=id year variable) xpt.have (keep=rename=variable=rol3mean);                                             
  by id year;                                                                                                             
run;quit;                                                                                                                 
libname xpt clear;                                                                                                        
                                                                                                                          
                                                                                                                          
/*                           _ _                                                                                          
  ___      ___  _ __   ___  | (_)_ __   ___ _ __                                                                          
 / __|    / _ \| `_ \ / _ \ | | | `_ \ / _ \ `__|                                                                         
| (__ _  | (_) | | | |  __/ | | | | | |  __/ |                                                                            
 \___(_)  \___/|_| |_|\___| |_|_|_| |_|\___|_|                                                                            
                                                                                                                          
*/                                                                                                                        
                                                                                                                          
Very nice Mark                                                                                                            
                                                                                                                          
*  WOW a one liner                                                                                                        
*  Longer windows possible by adding lags;                                                                                
*  Automatically takes care of non sequencial sequences within ID and changes in UD                                       
*  Should be very fast                                                                                                    
                                                                                                                          
data want;                                                                                                                
                                                                                                                          
  set have;                                                                                                               
  by id ;                                                                                                                 
                                                                                                                          
  rolling_mean=ifn(lag2(id)=id and lag2(year)=year-2                                                                      
                  ,mean(lag2(variable),lag(variable),variable)                                                            
                  ,.                                                                                                      
                  );                                                                                                      
run;                                                                                                                      
                                                                                                                          
/*   _     _   _                               _         _                                                                
  __| |   | |_| |__  _ __ ___  ___   _ __ ___ (_)___ ___(_)_ __   __ _                                                    
 / _` |   | __| `_ \| `__/ _ \/ _ \ | `_ ` _ \| / __/ __| | `_ \ / _` |                                                   
| (_| |_  | |_| | | | | |  __/  __/ | | | | | | \__ \__ \ | | | | (_| |                                                   
 \__,_(_)  \__|_| |_|_|  \___|\___| |_| |_| |_|_|___/___/_|_| |_|\__, |                                                   
                                                                 |___/                                                    
*/                                                                                                                        
                                                                                                                          
"                                                                                                                         
I suppose it depends upon what one wants.                                                                                 
                                                                                                                          
The approaches being described all seem to result in the moving average (for an N-point MA)                               
being 'missing' for a block of N time points (e.g. years) if data is missing for  just one time point.                    
                                                                                                                          
I use moving averages all the time, most commonly 7-day moving averages of daily data,                                    
and the requirement is usually for the 'MA' to be the average of however many (or few!)                                   
non-missing data figures are available over the 7 day period ending on any particular date                                
- so the moving average only becomes 'missing' if data for 7 consecutive days are missing.                                
                                                                                                                          
When I have missing data, there is usually an observation, but with the value of the                                      
data being absent.  However if, as in the data we are considering, there are actually                                     
missing observations, I first replace them with dummy ones (with variable=. ).                                            
I'm sure that there are probably simpler and/or more elegant ways of inserting the                                        
dummy observations than in the hastily-written brute force code below (for the data                                       
we are talking about) but, once that task is done,                                                                        
the data step to produce "this sort of MA" is again essentially just a one-liner.                                         
In this case, "this sort of MA" is only missing in one case, since, for the 3-point MA,                                   
Roger's data has one instance of there being three consecutive years' data missing ..."                                   
                                                                                                                          
data GapsFilled (drop = last_year this_year this_var) ;                                                                   
   set sd1.have ;                                                                                                         
   by ID ;                                                                                                                
   last_year = lag(year) ;                                                                                                
   this_year = year ;                                                                                                     
   this_var = variable ;                                                                                                  
   if ID = lag(ID) then do year = last_year +1 to year - 1 ;                                                              
      variable = . ;                                                                                                      
         output ;                                                                                                         
   end ;                                                                                                                  
   year = this_year ; variable = this_var ; output ;                                                                      
run ;                                                                                                                     
                                                                                                                          
data want ;                                                                                                               
   set GapsFilled ;                                                                                                       
   by ID ;                                                                                                                
   rolling_mean = mean(lag2(variable),lag(variable),variable) ;                                                           
run ;                                                                                                                     
                                                                                                                          
/*                                                                                                                        
  ___      __ _ _ __ _ __ __ _ _   _                                                                                      
 / _ \    / _` | `__| `__/ _` | | | |                                                                                     
|  __/_  | (_| | |  | | | (_| | |_| |                                                                                     
 \___(_)  \__,_|_|  |_|  \__,_|\__, |                                                                                     
                               |___/                                                                                      
*/                                                                                                                        
                                                                                                                          
%let window = 3;                                                                                                          
data want;                                                                                                                
  set sd1.have;                                                                                                           
  by id ;                                                                                                                 
                                                                                                                          
  array forAverage[&window.] _temporary_;                                                                                 
  if first.id or (year-lag(year)>1) then call missing(of forAverage[*]);                                                  
                                                                                                                          
  forAverage[mod(year, &window.)+1] = variable;                                                                           
                                                                                                                          
  if Nmiss(of forAverage[*]) then rolling_mean = .;                                                                       
                             else rolling_mean=mean(of forAverage[*]);                                                    
run;                                                                                                                      
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                 
                                                                                                                       
                                                                                                                                        
                                                                                                           
                                                                                                                                
                                                                                                                                
                                                                                                                                
