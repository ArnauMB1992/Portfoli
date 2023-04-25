/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A1;

import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class Ex07_ComptadorMines {
    
    public static Scanner sc = new Scanner(System.in);
    
    public static void main(String[] args) {
        
        //int[][] camp = demanarCampMines();
        int[][] camp = generarCampMines(true);
        Ex06_Matrius.mostraMatriu(camp);
        
        System.out.println("");
        
        //int[][] resultat = comptaMines(camp);
        comptaMines(camp);
        //Ex06_Matrius.mostraMatriu(resultat);
        Ex06_Matrius.mostraMatriu(camp);
        
    }
    
    /*
    public static int[][] demanarCampMines() {
                        
        System.out.print("Files: ");
        int files = sc.nextInt();
        
        System.out.print("Columnes: ");
        int columnes = sc.nextInt();
        
        int[][] campMines = new int[files][columnes];
        
        for (int i = 0; i < files; ++i) {
            for (int j = 0; j < columnes; ++j) {
                campMines[i][j] = sc.nextInt();
            }
        }
        
        return campMines;
        
    }*/
    
    public static int[][] generarCampMines(boolean automatic) {

        System.out.print("Files: ");
        int files = sc.nextInt();
        
        System.out.print("Columnes: ");
        int columnes = sc.nextInt();

        int[][] campMines = new int[files][columnes];
        
        for (int i = 0; i < files; ++i) {
            for (int j = 0; j < columnes; ++j) {
                /*if (Math.random() < 0.3)
                    campMines[i][j] = -1;
                else
                    campMines[i][j] = 0;*/
                
                if (automatic)
                    campMines[i][j] = (Math.random() < 0.3) ? -1 : 0;
                else
                    campMines[i][j] = sc.nextInt();
            }
        }
        
        return campMines;        
        
    }
    
    
    
    //public static int[][] comptaMines(int[][] camp) {
    public static void comptaMines(int[][] camp) {
        
        //int[][] taulerResultat = new int[camp.length][camp[0].length];
        
        for (int i = 0; i < camp.length; ++i) {
            for (int j = 0; j < camp[0].length; ++j) {
                
                if (camp[i][j] != -1)                    
                {
                    int comptador = 0;
                    /*if ((i-1) >= 0 && camp[i-1][j] == -1)
                        comptador++;
                    if ((i-1) >= 0 && (j-1) >= 0 && camp[i-1][j-1] == -1)
                        comptador++;*/
                    for (int inci = -1; inci <= 1; ++inci) {
                        for (int incj = -1; incj <= 1; ++incj) {
                            if ((i+inci) >= 0 && (i+inci) < camp.length &&
                                (j+incj) >= 0 && (j+incj) < camp[0].length &&
                                camp[i+inci][j+incj] == -1)
                                
                                comptador++;
                        }
                    }
                    //taulerResultat[i][j] = comptador;
                    camp[i][j] = comptador;
                    
                }
            }   
        }
        
        
        //return taulerResultat;
    }
}


