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
public class Ex09_SudokuCorrecte_solucionOnline {

    public static boolean esFilaValida(int[][] m, int f) {
        int[] test = new int[9];
        for (int c = 0; c < m.length; c++) {
            if (test[m[f][c]-1] == 1) return false;
            test[m[f][c]-1] = 1;
        }
        return true;
    }

    public static boolean esColumnaValida(int[][] m, int c) {
        int[] test = new int[9];
        for (int f = 0; f < m.length; f++) {
            if (test[m[f][c]-1] == 1) return false;
            test[m[f][c]-1] = 1;
        }
        return true;
    }

    public static boolean esRegioValida(int[][] m) {
        int max, x, y;
        int[] valores = {0, 3, 6, 0, 3, 6, 0, 3, 6};
        for (int l = 0; l < 9; l++) {
            x = y = valores[l];
            max = x + 3;
            int[] test = new int[9];
            for (int i = x; i < max; i++) {
                for (int j = y; j < max; j++) {
                    if (test[m[i][j]-1] == 1) return false;
                    test[m[i][j]-1] = 1;
                }
            }
        }
        return true;
    }

    public static void main(String[] args) {

        Scanner s = new Scanner(System.in);

        /**
         * 1.- Comprobar filas
         * 2.- Comprobar columnas
         * 3.- Comprobar apartados
         */

        int casos = s.nextInt();
        int[][] sudoku;
        boolean valido;

        for (int l = 0; l < casos; l++) {

            sudoku = new int[9][9];
            for (int i = 0; i < 9; i++)
                for (int j = 0; j < 9; j++)
                    sudoku[i][j] = s.nextInt();

            // COMPROBAR FILAS COLUMNAS
            valido = true;
            for (int i = 0; i < 9; i++) {
                if (!esFilaValida(sudoku, i)) valido = false;
                if (valido && !esColumnaValida(sudoku, i)) valido = false;
                if (!valido) break;
            }

            if (valido)
                valido = esRegioValida(sudoku);

            System.out.println( (valido) ? "SI" : "NO");
        }

    }

}