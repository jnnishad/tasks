#!/bin/bash

function processor(){

 lscpu|grep ^[A-L]	

}


function callback(){


processor |grep ^L


}



callback
