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
  echo TOTAL Linea 53, Ambas, $t_aprox, $t_estac, $t_salid, $t_inter


  t_aprox=`grep _1 APROX.txt | wc -l`
  t_estac=`grep _1 ESTAC.txt | wc -l`
  t_salid=`grep _1 SALIDA.txt | wc -l`
  t_inter=`grep _1 INTEREST.txt | wc -l`
  echo TOTAL L53 Via 1, 1, $t_aprox, $t_estac, $t_salid, $t_inter

  t_aprox=`grep _2 APROX.txt | wc -l`
  t_estac=`grep _2 ESTAC.txt | wc -l`
  t_salid=`grep _2 SALIDA.txt | wc -l`
  t_inter=`grep _2 INTEREST.txt | wc -l`
  echo TOTAL L53 Via 2, 2, $t_aprox, $t_estac, $t_salid, $t_inter
  echo ""
  echo ""

for i in PUERTA_BOADILLA_1 INFANTE_DON_LUIS_1 SIGLO_XXI_1 NUEVO_MUNDO_1 BOADILLA_CENTRO_1 FERIAL_BOADILLA_1 CANTABRIA_1 PRADO_ESPINO_1 VENTORRO_CANO_1 MONTEPRINCIPE_1 RETAMARES_1 METRO_LIGERO_1 CIUDAD_CINE_1 JOSE_ISBERT_1 CIUDAD_IMAGEN_1 COLONIA_JARDIN_1
do
  t_aprox=`grep $i APROX.txt | wc -l`
  t_estac=`grep $i ESTAC.txt | wc -l`
  t_salid=`grep $i SALIDA.txt | wc -l`
  t_inter=`grep $i INTEREST.txt | wc -l`
  echo $i, 1, $t_aprox, $t_estac, $t_salid, $t_inter
  echo ""
done


for i in COLONIA_JARDIN_2 CIUDAD_IMAGEN_2 JOSE_ISBERT_2 CIUDAD_CINE_2 METRO_LIGERO_2 RETAMARES_2 MONTEPRINCIPE_2 VENTORRO_CANO_2 PRADO_ESPINO_2 CANTABRIA_2 FERIAL_BOADILLA_2 BOADILLA_CENTRO_2 NUEVO_MUNDO_2 SIGLO_XXI_2 INFANTE_DON_LUIS_2 PUERTA_BOADILLA_2
do
  t_aprox=`grep $i APROX.txt | wc -l`
  t_estac=`grep $i ESTAC.txt | wc -l`
  t_salid=`grep $i SALIDA.txt | wc -l`
  t_inter=`grep $i INTEREST.txt | wc -l`
  echo $i, 2, $t_aprox, $t_estac, $t_salid, $t_inter
  echo ""
done

rm APROX.txt ESTAC.txt SALIDA.txt INTEREST.txt

