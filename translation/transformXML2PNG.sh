#!/bin/bash

../fop/fop -xml wetter.xml -xsl forecastXML2fo.xsl -param lang en -png forecast.png