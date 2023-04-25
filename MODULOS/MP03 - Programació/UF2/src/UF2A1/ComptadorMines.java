/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A1;

/**
 *
 * @author ArnauMB
 */
import static UF2A1.Ex06_Matrius.mostraMatriu;
import java.util.Scanner;
import java.util.Random;

public class ComptadorMines {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random rnd = new Random();
        
        // Demanar al usuari les dimensions de la matriu
        System.out.print("Introdueix el nombre de files: ");
        int files = sc.nextInt();
        System.out.print("Introdueix el nombre de columnes: ");
        int columnes = sc.nextInt();
        
        // Crear la matriu de mines amb valors aleatoris
        int[][] campMines = new int[files][columnes];
        for (int i = 0; i < files; i++) {
            for (int j = 0; j < columnes; j++) {
//                if (rnd.nextDouble() < 0.25) {
//                    campMines[i][j] = -1;
//                } else {
//                    campMines[i][j] = 0;
//                }
                  campMines[i][j] = (rnd.nextDouble() < 0.25) ? -1 : 0;
            }
        }
        
        // Imprimir la matriu de mines
        System.out.println("Mines:");
        Ex06_Matrius.mostraMatriu(campMines);
        
        // Comptar les mines adjacents i crear la nova matriu
        int[][] minesAdjacents = comptaMines(campMines);
        
        // Imprimir la nova matriu
        System.out.println("Mines adjacents:");
        Ex06_Matrius.mostraMatriu(minesAdjacents);
    }
    
    public static int[][] comptaMines(int[][] camp) {
        int files = camp.length;
        int columnes = camp[0].length;
        int[][] resultat = new int[files][columnes];
        
        // Recórrer tota la matriu
        for (int i = 0; i < files; i++) {
            for (int j = 0; j < columnes; j++) {
                // Si hi ha una mina, el valor de la casella corresponent en la nova matriu serà -1
                if (camp[i][j] == -1) {
                    resultat[i][j] = -1;
                } else {
                    int minesAdjacents = 0;
                    // Recórrer les caselles adjacents
                    for (int k = i - 1; k <= i + 1; k++) {
                        for (int l = j - 1; l <= j + 1; l++) {
                            // Comprovar si la casella està dins la matriu i no és la casella actual
                            if (k >= 0 && k < files && l >= 0 && l < columnes && !(k == i && l == j)) {
                                if (camp[k][l] == -1) {
                                    minesAdjacents++;
                                }
                            }
                        }
                    }
                    resultat[i][j] = minesAdjacents;
                }
            }
        }
        
        return resultat;
    }

}
