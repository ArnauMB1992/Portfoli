/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A2;

import java.util.*;

/**
 *
 * @author ArnauMB
 */
public class CercaBinariaPaisos {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // Llegim el valor N
        int n = sc.nextInt();
        sc.nextLine(); // Consumim el salt de línia

        // Creem un array de cadenes de caràcters per emmagatzemar els països
        String[] paisos = new String[n];

        // Llegim els països i els afegim a l'array
        for (int i = 0; i < n; i++) {
            paisos[i] = sc.nextLine();
        }

        // Ordenem l'array alfabèticament
        Arrays.sort(paisos);

        // Llegim el país a buscar
        String paisBuscat = sc.nextLine();

        // Fem la cerca binària
        int posicio = cercaBinaria(paisos, paisBuscat);

        // Mostrem el resultat
        if (posicio >= 0) {
            System.out.println("Trobat a la posició: " + posicio);
        } else {
            System.out.println("No trobat");
        }
    }

    // Mètode de cerca binària per trobar la posició d'un valor en un array ordenat
    static int cercaBinaria(String[] array, String valor) {
        int esquerra = 0;
        int dreta = array.length - 1;
        int passades = 0;
        while (esquerra <= dreta) {
            passades++;
            int mig = (esquerra + dreta) / 2;

            int comparacio = valor.compareTo(array[mig]);

            if (comparacio == 0) {
                return mig;
            } else if (comparacio < 0) {
                dreta = mig - 1;
            } else {
                esquerra = mig + 1;
            }
        }
        System.out.println("Total passades: "+passades);
        return -1; // No s'ha trobat el valor
    }
}


