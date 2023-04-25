/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uf2;

import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class JocDeTaula {
    static final int CASELLAPERFILA = 8;
    static final int TOTALBLANCAS = 20;
    
    public static void main(String[] args) {
        int[][] tauler = creaTauler();
        Scanner sc = new Scanner(System.in);
        final int MAXINTENTS = 10, MAXNEGRAS = 4;
        
        int intents = 0, totalNegras = 0;
        
        while(intents<MAXINTENTS&&totalNegras<MAXNEGRAS){
            
            System.out.println("Intent "+(intents+1)+":");
            System.out.print("Fila: ");
            int fila=sc.nextInt();
            System.out.print("Columna: ");
            int col=sc.nextInt();
            
//            boolean tocaV = tocaVora(fila,col);   me ahorro una variable, metiendolo dentro del if
            if(/*tocaV*/tocaVora(fila,col)){
                System.out.println("No és vàlida. Toca la vora! ");
            }else if(existeixFitxa(tauler, fila,col)){
                System.out.println("No és vàlida. Ja hi ha una fitxa!");
            }else{
                System.out.println("Perfecte! La posició és vàlida");
                tauler[fila][col]=2;
                totalNegras++;
                
            }
            
            intents++;
        }
        if(totalNegras==MAXNEGRAS){
            System.out.println("Enhorabona! Has guanyat!");
        }else{
            System.out.println("OOOOOoooohhhh! Has perdut!!");
    
        }   
        mostraTauler(tauler);
        
    }
    
    static int[][] creaTauler(){
        
        int[][] taulerNou = new int[CASELLAPERFILA][CASELLAPERFILA] ;
        
        int fichasBlancas=0;
        
        do{
            int fila = (int)(Math.random()*CASELLAPERFILA);
            int col= (int)(Math.random()*CASELLAPERFILA);           
            if(!existeixFitxa(taulerNou,fila,col)){
                taulerNou[fila][col]= 1;
                fichasBlancas++;
            }
            
        }while(fichasBlancas<TOTALBLANCAS);

        return taulerNou;
    }
    
    static boolean tocaVora(int fila, int columna) {
        return (fila==1||fila==CASELLAPERFILA ||
               columna==1 || columna==CASELLAPERFILA);
    }
    
    static boolean existeixFitxa(int[][] tauler, int fila, int columna){
//        
//        me lo ahorro poniendolo en el return
//        boolean resultat =false;
//        if(tauler[fila][columna]!=0){
//            resultat =true;
//        }
//        return resultat;
        
        return (tauler[fila][columna]!=0);
    }
    
    static void mostraTauler(int[][] tauler) {
        System.out.println("\nMostra Tauler: ");       
        for (int[] fila : tauler) {
            for (int valor : fila) {
                switch(valor){
                    case 0:
                        System.out.print(valor+" ");
                        break;
                    case 1:
                        System.out.print("B ");
                        break;
                    case 2:
                        System.out.print("N ");
                        break;
                }       

            }
            System.out.println("");
        } 
    }
    
    
}
