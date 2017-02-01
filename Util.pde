//ijava.util.Date
import java.text.SimpleDateFormat;
static int RAIN = 0;


int toMillisecond(int min,int second, int millisecond){
  
  return (min*60+second)*1000+millisecond;

}

int toMillisecond(int min,int second){
  
  return (min*60+second)*1000;

}

String toTimeDisplay(int millisecond){
  SimpleDateFormat dateFormatter = new SimpleDateFormat("m:ss");
  Date time = new Date(millisecond);
  
  String timeStr =  dateFormatter.format(time);
//  String timeStr = time.getMinutes() + ":" + time.getSeconds();
  
  return timeStr;
}