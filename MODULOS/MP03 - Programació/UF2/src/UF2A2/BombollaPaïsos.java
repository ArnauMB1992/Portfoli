/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A2;

import java.util.Scanner;

public class BombollaPaïsos {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Introduïu el nombre de països: ");
        int n = sc.nextInt();
         sc.nextLine();
        String[] paisos = new String[n];
        for (int i = 0; i < n; i++) {
            System.out.print("Introduïu el nom del país " + (i + 1) + ": ");
            paisos[i] = sc.nextLine();
        }
        ordenaBombolla(paisos);
        System.out.println("Països ordenats:");
        for (String pais : paisos) {
            System.out.println(pais);
        }
    }

    public static void ordenaBombolla(String[] paisos) {
        int n = paisos.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (paisos[j].compareToIgnoreCase(paisos[j+1]) > 0) {
                    String temp = paisos[j];
                    paisos[j] = paisos[j+1];
                    paisos[j+1] = temp;
                }
            }
        }
    }
}
