package com.yape.apitest.basetemplate;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;
 
@RunWith(Karate.class)
@KarateOptions(features = "classpath:com/yape/apitest/basetemplate/yape-services", tags = "~@ignore")
public class YapeRunner {
 
}