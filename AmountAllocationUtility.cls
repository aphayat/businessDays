public class AmountAllocationUtility {
    
    public static integer getBusinessDays(date startDate, date endDate ){
        Integer extraDays = 0;
        
        date firstWeekDate = startDate.toStartOfWeek();
        date endWeekDate = endDate.toStartOfWeek().addDays(6);
        
        Integer numberDaysDue = firstWeekDate.daysBetween(endWeekDate)+1;
        
        integer absweeks=numberDaysDue/7;
        
        integer wokringDays=absweeks*5;
        
        //minus Extra Days added -- Start 
        
        
        date tempstartDate=firstWeekDate;
        
       // return extra days
        extraDays = calExtraDays(tempstartDate, startDate);
        
        //system.debug('i-1:'+i); 
        wokringDays=wokringDays-extraDays;
        //system.debug('wokringDays-1:'+wokringDays); 
        
        //minus Extra Days added -- End 
        
        extraDays=0;
        tempstartDate=endDate;
        
        extraDays = calExtraDays(tempstartDate, endWeekDate);
       
        wokringDays=wokringDays-extraDays+1;
        
        return wokringDays;
        
    }
    
    public static integer calExtraDays(date tempstartDate, date endWeekDate){
        integer extraDays = 0; 
        while (tempstartDate < endWeekDate) {
            DateTime myDateTime =  DateTime.newInstance(tempstartDate.year(),tempstartDate.month(),tempstartDate.day());
            String dayOfWeek = myDateTime.format('E');
            //system.debug('i'+dayOfWeek);   
            //system.debug('myDateTime***'+myDateTime);   
            if (dayOfWeek != 'Sat' && dayOfWeek  != 'Sun') 
            {
                extraDays++;
            }
            tempstartDate = tempstartDate.addDays(1);
        }
        return extraDays;
    }
 
    
    public static decimal calPerDayAmount(integer businessDay, decimal oppAmount){
        decimal perDayAmount;
        perDayAmount = oppAmount / businessDay;
        return perDayAmount;
    }
    
    public static integer getTotalAmountAllocationRec(Date StartDate,Date EndDate){
        integer totalAllocationRecord=0;
        totalAllocationRecord = startDate.monthsBetween(EndDate);
        return totalAllocationRecord;
    }
    
    public static date getCloseDate(Date StartDate, Date OppCloseDate){
        date AmtAllocationCloseDate ;
        system.debug('Start Date******'+startDate);
        system.debug('OppCloseDate Date******'+OppCloseDate);
        if(StartDate.month() == OppCloseDate.month() && StartDate.year()== OppCloseDate.year()){
            system.debug('returning Date******'+OppCloseDate);    
            return OppCloseDate;
        }
        
        Integer numberOfDays = Date.daysInMonth(StartDate.year(), StartDate.month());
        AmtAllocationCloseDate = Date.newInstance(StartDate.year(), StartDate.month(), numberOfDays);
        
        return AmtAllocationCloseDate;
    }
    
    public static decimal getAmount(Date StartDate, Date EndDate,decimal perDayAmount){
        decimal monthlyAmount=0;
        integer businessDays = getBusinessDays(StartDate,EndDate);
        system.debug('***********Monthly Start Date********'+StartDate);
        system.debug('***********Monthly End Date*****'+EndDate);
        system.debug('***********Monthly Business Days*****'+businessDays);
        monthlyAmount = perDayAmount * businessDays;
        monthlyAmount = monthlyAmount;
        return monthlyAmount;
    }
}