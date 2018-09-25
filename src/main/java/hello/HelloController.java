package hello;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

@RestController
public class HelloController {


   @Autowired
    private Environment env;    

    @RequestMapping("/")
    public String index() {
        return "Greetings from Spring Boot Hello World Service!";
    }


     @RequestMapping(value="/hello/zip/{zipcode}", method = RequestMethod.GET)
	public String getWeatherForZip(@PathVariable("zipcode") String zipcode) 
  {   
	String url ="http://" + "weather-service:8080" + "/weather/zip/" + zipcode ;  	
	 try {
	   RestTemplate restTemplate = new RestTemplate();
	   String result = restTemplate.getForObject(url, String.class);
	   return "In Hello Service : Getting weather from weather service for Zip Code :" + result;
	  }
	catch (Exception e) {
		return url ;
	}// end catch		
  }// end method 


     @RequestMapping(value="/hello/{zipcode}", method = RequestMethod.GET)
	public String getWeatherByCallingElb(@PathVariable("zipcode") String zipcode) 
  {   
	
	String elbUrl = env.getProperty("ELB_DNS");
   	String weatherServicePort = env.getProperty("WEATHER_SERVICE_PORT");
	String url = "http://" + elbUrl + ":" + weatherServicePort + "/weather/zip/" + zipcode ;
	try {
		RestTemplate restTemplate = new RestTemplate();
	        String result = restTemplate.getForObject(url, String.class);
		return result;
	  }
	catch (Exception e) {
		return url ;
	}// end catch		
  }// end method 

}// end class

