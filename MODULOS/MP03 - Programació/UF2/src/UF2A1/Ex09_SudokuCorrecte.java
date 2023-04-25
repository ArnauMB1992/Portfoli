package UF2A1;

import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class Ex09_SudokuCorrecte {
    
    static final int TOTAL = 9;    
    static Scanner sc = new Scanner(System.in);
    
    public static void main(String[] args) {
        
        
        int totalSudokus = sc.nextInt();
        
        for (int num = 0; num < totalSudokus; ++num) {
            int[][] sudoku = llegirSudoku();
            //mostrarSudoku(sudoku);

            boolean valid = true;
            for (int i = 0; i < TOTAL; ++i) {            
                if (!esFilaValida(sudoku,i) || !esColumnaValida(sudoku,i)) {                
                    valid = false;
                    break;                
                }
            }

            for (int i = 0; i <= 6 && valid; i+=3) {
                for (int j = 0; j <= 6; j+=3) {
                    if (!esRegioValida(sudoku,i,j)) {
                        valid = false;
                        break;
                    }
                }
            }

            
//        if (valid)
//            System.out.println("SI");
//        else
//            System.out.println("NO");

        System.out.println(valid ? "SI" : "NO");
        }
    }
    
    
    static int[][] llegirSudoku() {
                                        
        int[][] resultat = new int[TOTAL][TOTAL];
        
        for (int fila = 0; fila < TOTAL; fila++) {
            for (int col = 0; col < TOTAL; col++) {
                resultat[fila][col] = sc.nextInt();
            }
        }
        
        return resultat;
    }
    
//    
//    static void mostrarSudoku(int[][] sudoku) {
//    
//        System.out.println("Valors del sudoku:");
//        
//        for (int[] fila : sudoku) {
//            for (int valor : fila) {
//                System.out.print(valor + " ");                
//            }
//            System.out.println("");
//        }
//        
//    }
    
    static boolean esFilaValida(int[][] sudoku, int fila) {
        
        boolean resultat = true;
        
        /* Alternativa 1 */
        for (int valor = 1; valor <= TOTAL; ++valor) {
            int comptador = 0;
            for (int col = 0; col < TOTAL; ++col) {
                if (sudoku[fila][col] == valor) {
                    comptador++;
                }            
            }            
            if (comptador > 1) {
                resultat = false;
                break;
            }
        }
        
        /* Alternativa 2 */
        /*
        boolean[] array = new boolean[TOTAL];
        
        for (int col = 0; col < TOTAL; ++col) {
            if (array[sudoku[fila][col]-1]) {
                resultat = false;
                break;
            } else {
                array[sudoku[fila][col]-1] = true;
            }
        }
        */
        return resultat;
    }

    static boolean esColumnaValida(int[][] sudoku, int col) {
        
        boolean resultat = true;
        
        /* Alternativa 1 */
        for (int valor = 1; valor <= TOTAL; ++valor) {
            int comptador = 0;
            for (int fila = 0; fila < TOTAL; ++fila) {
                if (sudoku[fila][col] == valor) {
                    comptador++;
                }            
            }            
            if (comptador > 1) {
                resultat = false;
                break;
            }
        }
        
        /* Alternativa 2 */
        /*
        boolean[] array = new boolean[TOTAL];
        
        for (int fila = 0; fila < TOTAL; ++fila) {
            if (array[sudoku[fila][col]-1]) {
                resultat = false;
                break;
            } else {
                array[sudoku[fila][col]-1] = true;
            }
        }*/
        
        return resultat;
    }    
    
    static boolean esRegioValida(int[][] sudoku, int filaInicial, 
                                                 int columnaInicial) {
        boolean resultat = true;
                
        for (int valor = 1; valor <= TOTAL; ++valor) {
            int comptador = 0;
            for (int i = 0; i < 3; ++i) {
                for (int j = 0; j < 3; ++j) {
                    if (sudoku[filaInicial+i][columnaInicial+j] == valor)
                        comptador++;
                }
            }
            if (comptador > 1) {
                resultat = false;
                break;
            }
        }
        
        /* Alternativa 2 */
        /*
        boolean[] array = new boolean[TOTAL];
        
        for (int i = 0; i < 3 && resultat; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (array[sudoku[filaInicial+i][columnaInicial+j]-1]) {
                    resultat = false;
                    break;
                } else {
                    array[sudoku[filaInicial+i][columnaInicial+j]-1] = true;
                }
            }
        }*/
        
        
        return resultat;
        
    }
}
