package com.example.streaming;

import org.apache.solr.common.SolrInputDocument;
import com.lucidworks.spark.SolrSupport;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class EventParseUtil {
	
    public EventParseUtil() {
		super();
	}
	

	 static SolrInputDocument convertData (String incomingRecord) throws NumberFormatException, ParseException {
			
		 System.out.println(incomingRecord);
		 String[] inputArray = incomingRecord.split(",");
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
		 
		 EventDataElement eventDataElement = null;

			if (inputArray.length == 3) {
				
				eventDataElement = new EventDataElement(
						inputArray[0], inputArray[1], inputArray[2]);
						//sdf.parse(inputArray[4]),
					//	Integer.valueOf(inputArray[5]).intValue(),
					//	inputArray[6], inputArray[7], inputArray[8]);

			}
			System.out.println(eventDataElement);
			SolrInputDocument solrDoc =
	                  SolrSupport.autoMapToSolrInputDoc(inputArray[0]+ "_" + inputArray[1], eventDataElement, null);
			
			return solrDoc;
	 }
}
