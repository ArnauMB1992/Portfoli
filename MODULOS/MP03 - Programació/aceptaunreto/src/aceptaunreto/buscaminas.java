/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package aceptaunreto;

import java.util.Scanner;

/**
 *
 * @author Arnau Muñoz
 */
public class buscaminas {
 public static void main(String[] args) {
        
        Scanner sc = new Scanner(System.in);

        int amplada = -1;
        int alcada  = -1;
        
        while (true)
        {
            amplada = sc.nextInt();
            alcada  = sc.nextInt();
            
            // Sortim si els dos valors són 0
            if (amplada == 0 && alcada == 0)
                break;
            
            boolean[][] tauler = new boolean[alcada][amplada];
            sc.nextLine();
            
            // Omplir les dades
            // Recorrem totes les files
            for (int i = 0; i < alcada; ++i) 
            {
                String cadenaFila = sc.nextLine();
                // Recorrem totes les columnes de cada fila
                for (int j = 0; j < amplada; ++j)
                {
                    // Opció 1
                    /*                    
                    char caracter = cadenaFila.charAt(j);
                    if (caracter == '*')
                        tauler[i][j] = true;
                    else
                        tauler[i][j] = false;*/
                    
                    // Opció 2
                    /*tauler[i][j] = (cadenaFila.charAt(j) == '*') ? true : false;*/
                    
                    // Opció 3
                    if (cadenaFila.charAt(j) == '*')
                        tauler[i][j] = true;                    
                }
            }
            
            
            int totalMes6Mines = 0;
            for (int i = 0; i < alcada; ++i)
            {
                for (int j = 0; j < amplada; ++j)
                {
                    //if ()
                    int numMinas = 0;
                    
                    if (!tauler[i][j])
                    {
                        // Opció 1
                        /*if ((i-1) >= 0 && (j-1) >= 0 && tauler[i-1][j-1] == true)
                            numMinas++;
                        if ((i-1) >= 0 && tauler[i-1][j] == true)
                            numMinas++;
                        if ((i-1) >= 0 && (j+1) < amplada && tauler[i-1][j+1] == true)
                            numMinas++;
                        ...
                        */

                        // Opció 2
                        for (int ifila = -1; ifila <= 1; ++ifila)
                        {
                            for (int icol = -1; icol <= 1; ++icol)
                            {
                                if (i+ifila >= 0 && i+ifila < alcada &&
                                    j+icol >= 0  && j+icol  < amplada &&
                                    tauler[i+ifila][j+icol])
                                    numMinas++;
                            }
                        }

                        if (numMinas >= 6) 
                            totalMes6Mines++;
                    }                    
                }
            }
            System.out.println(totalMes6Mines);            
        }
    }
}