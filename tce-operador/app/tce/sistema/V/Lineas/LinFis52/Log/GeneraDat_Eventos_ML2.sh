#!/bin/sh
#
# Copyright: SICOSOFT 2009
#
# Historia:
#
#          17-Abr-09 Carlos Culebras                Codigo inicial
#
# Por hacer:
#
# NOTAS:
#
#    Este script genera una salida que puede ser leida directamente por Excel, Access, Oracle, etc.
#

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/ucb
export PATH

 Fich=$1

   if [ -z "$Fich" ]; then
      echo ""
      echo "Por favor, indique el Fichero con los Eventos de Trenes"
      echo "SINTAXIS: $0 <Fichero>"
      echo ""
      exit 1
   fi

 grep SALIDA $Fich | grep -v APROX | grep -v INTER | grep -v INCOHERENCIA > SALIDA.txt
 grep INTER $Fich  | grep -v APROX | grep -v SALIDA > INTEREST.txt
 grep APROX $Fich  | grep -v INTER | grep -v SALIDA > APROX.txt
 grep ESTAC $Fich  | grep -v SALIDA | grep -v APROX | grep -v INTER > ESTAC.txt

  t_aprox=`cat APROX.txt |wc -l`
  t_estac=`cat ESTAC.txt | wc -l`
  t_salid=`cat SALIDA.txt| wc -l`
  t_inter=`cat INTEREST.txt |wc -l`
  echo TOTAL Linea 52, Ambas, $t_aprox, $t_estac, $t_salid, $t_inter


  t_aprox=`grep _1 APROX.txt | wc -l`
  t_estac=`grep _1 ESTAC.txt | wc -l`
  t_salid=`grep _1 SALIDA.txt | wc -l`
  t_inter=`grep _1 INTEREST.txt | wc -l`
  echo TOTAL L52 Via 1, 1, $t_aprox, $t_estac, $t_salid, $t_inter

  t_aprox=`grep _2 APROX.txt | wc -l`
  t_estac=`grep _2 ESTAC.txt | wc -l`
  t_salid=`grep _2 SALIDA.txt | wc -l`
  t_inter=`grep _2 INTEREST.txt | wc -l`
  echo TOTAL L52 Via 2, 2, $t_aprox, $t_estac, $t_salid, $t_inter
  echo " "
  echo " "

for i in ESTACION_ARAVACA_1 BERNA_1 AVENIDA_EUROPA_1 CAMPUS_SOMOSAGUAS_1 DOS_CASTILLAS_1 BELGICA_1 POZUELO_OESTE_1 SOMOSAGUAS_CENTRO_1 SOMOSAGUAS_SUR_1 PRADO_REY_1 COLONIA_ANGELES_1 PRADO_VEGA_1 COLONIA_JARDIN_1
do
  t_aprox=`grep $i APROX.txt | wc -l`
  t_estac=`grep $i ESTAC.txt | wc -l`
  t_salid=`grep $i SALIDA.txt | wc -l`
  t_inter=`grep $i INTEREST.txt | wc -l`
  echo $i, 1, $t_aprox, $t_estac, $t_salid, $t_inter
  echo " "
done


echo ""
for i in COLONIA_JARDIN_2 PRADO_VEGA_2 COLONIA_ANGELES_2 PRADO_REY_2 SOMOSAGUAS_SUR_2 SOMOSAGUAS_CENTRO_2 POZUELO_OESTE_2 BELGICA_2 DOS_CASTILLAS_2 CAMPUS_SOMOSAGUAS_2 AVENIDA_EUROPA_2 BERNA_2 ESTACION_ARAVACA_2
do
  t_aprox=`grep $i APROX.txt | wc -l`
  t_estac=`grep $i ESTAC.txt | wc -l`
  t_salid=`grep $i SALIDA.txt | wc -l`
  t_inter=`grep $i INTEREST.txt | wc -l`
  echo $i, 2, $t_aprox, $t_estac, $t_salid, $t_inter
  echo " "
done

rm APROX.txt ESTAC.txt SALIDA.txt INTEREST.txt

