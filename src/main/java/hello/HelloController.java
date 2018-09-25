package hello;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
public class HelloController {

    @RequestMapping("/")
    public String index() {
        return "Greetings from Spring Boot Hello World Service!";
    }


	@RequestMapping(value="/hello/zip/{zipcode}", method = RequestMethod.GET)
	public String getWeatherForZip(@PathVariable("zipcode") String zipcode) {   
	   return "Getting weather from weather service for Zip Code :" + zipcode;
	}

}
