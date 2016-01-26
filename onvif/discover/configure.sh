#!/bin/bash
#create by liulu
#用于online生成对应的onvif源码
#url+="http://www.onvif.org/onvif/ver10/device/wsdl/devicemgmt.wsdl   "
#url+="http://www.onvif.org/onvif/ver10/events/wsdl/event.wsdl  "
#url+="http://www.onvif.org/onvif/ver10/display.wsdl "
#url+="http://www.onvif.org/onvif/ver10/deviceio.wsdl  "
#url+="http://www.onvif.org/onvif/ver20/imaging/wsdl/imaging.wsdl   "
#url+="http://www.onvif.org/onvif/ver10/media/wsdl/media.wsdl  "
#url+="http://www.onvif.org/onvif/ver20/media/wsdl/media.wsdl "
#url+="http://www.onvif.org/onvif/ver20/ptz/wsdl/ptz.wsdl "
#url+="http://www.onvif.org/onvif/ver10/receiver.wsdl "
#url+="http://www.onvif.org/onvif/ver10/recording.wsdl "
#url+="http://www.onvif.org/onvif/ver10/search.wsdl "
#url+="http://www.onvif.org/onvif/ver10/replay.wsdl "
#url+="http://www.onvif.org/onvif/ver20/analytics/wsdl/analytics.wsdl "
#url+="http://www.onvif.org/onvif/ver10/analyticsdevice.wsdl "
#url+="http://www.onvif.org/onvif/ver10/schema/onvif.xsd "
#url+="http://www.onvif.org/ver10/actionengine.wsdl "
#url+="http://www.onvif.org/ver10/pacs/accesscontrol.wsdl "
#url+="http://www.onvif.org/ver10/pacs/doorcontrol.wsdl "
#url+="http://www.onvif.org/ver10/advancedsecurity/wsdl/advancedsecurity.wsdl "
#url+="http://www.onvif.org/ver10/accessrules/wsdl/accessrules.wsdl "
#url+="http://www.onvif.org/ver10/credential/wsdl/credential.wsdl "
#url+="http://www.onvif.org/ver10/schedule/wsdl/schedule.wsdl "
#url+="http://www.onvif.org/ver10/pacs/types.xsd "
url+="http://www.onvif.org/onvif/ver10/network/wsdl/remotediscovery.wsdl "
if [ "$1" == "clean" ];then
    #删除configure.sh以外的所有文件
    #ls | grep "[^configure.sh]" | xargs rm -rf
    rm xml -rf
    rm onvif.h -rf
    rm soapC.c soapH.h soapStub.h -rf
    rm soapClientLib.c soapClient.c -rf
    rm soapServerLib.c  soapServer.c -rf
    rm RemoteDiscoveryBinding.nsmap wsdd.nsmap -rf
else 
    echo $url 
    # -c 表示生成c代码，默认生产cpp代码
    wsdl2h -c -s -t../gsoap/typemap.dat -o onvif.h $url
    if [ $? -ne 0 ];then
        echo "Error"
        exit -1
    fi
    soapcpp2 -I../gsoap/ onvif.h
    if [ $? -ne 0 ];then
        echo "Error"
        exit -1
    fi
    mkdir -p xml 
    mv *.xml xml
fi

