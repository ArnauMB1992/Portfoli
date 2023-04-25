/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A1;

import java.util.Random;
import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class Ex06_Matrius {
  public static Scanner sc = new Scanner(System.in);
  public static void main(String[] args) {
//    Random r = new Random();

    System.out.print("Introduce el número de filas: ");
    int filas = sc.nextInt();
    System.out.print("Introduce el número de columnas: ");
    int columnas = sc.nextInt();
    System.out.print("Introduce el valor mínimo: ");
    int min = sc.nextInt();
    System.out.print("Introduce el valor máximo: ");
    int max = sc.nextInt();

    int[][] matriu1 = demanaMatriu(filas, columnas);
    int[][] matriu2 = generaMatriu(filas, columnas, min, max);

    System.out.println("Matriu 1: ");
    mostraMatriu(matriu1);
    System.out.println("Matriu 2: ");
    mostraMatriu(matriu2);

    sc.close();
  }

  public static void mostraMatriu(int[][] matriu) {
    for (int i = 0; i < matriu.length; i++) {
      for (int j = 0; j < matriu[i].length; j++) {
        System.out.print(matriu[i][j] + "\t");
      }
      System.out.println();
    }
  }

  public static int[][] demanaMatriu(int files, int columnes) {
    int[][] matriu = new int[files][columnes];

    System.out.println("Introduce los valores para la matriu: ");
    for (int i = 0; i < files; i++) {
      for (int j = 0; j < columnes; j++) {
        System.out.print("Introduce el valor para la fila " + (i + 1) + " y la columna " + (j + 1) + ": ");
        matriu[i][j] = sc.nextInt();
      }
    }

    //sc.close();
    return matriu;
  }

  public static int[][] generaMatriu(int files, int columnes, int min, int max) {
    //Random r = new Random();
    int[][] matriu = new int[files][columnes];
    
    for (int i = 0; i < files; i++) {
      for (int j = 0; j < columnes; j++) {
        matriu[i][j] = (int)(Math.random()*(max-min+1))+min;
                     //r.nextInt((max - min) + 1) + min;
      }
    }
    
    return matriu;
  }
}