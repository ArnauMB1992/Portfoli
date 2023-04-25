/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A2;

/**
 *
 * @author ArnauMB
 */
public class Ex01_VectorsAleatoris {
    static int ELEMENTS = 10;
    public static void main(String[] args) {
        //A[]
        int[]a=crearVector(0,9);
        //B[]
        int[]b=crearVector(100,999);
        //C[]
        int[]c=crearVector(a,b);
        //MUESTRA VECTOR
         mostrarVector(a,"A");
         mostrarVector(b,"B");
         mostrarVector(c,"C");
    }
    static int[] crearVector(int min, int max){
        
        int[] v = new int[ELEMENTS];
        for (int i = 0; i < ELEMENTS; i++) {
        v[i] = (int)(Math.random()*(max-min+1))+min;
        }
        return v;
    }
    static int[] crearVector(int[] v1, int[] v2){
        
        int[] v = new int[ELEMENTS*2];
                for (int i = 0; i < 2 * ELEMENTS; i++) {
            if (i % 2 == 0)
                v[i] = v1[i/2];
                  else
                v[i] = v2[i/2];
        }

        return v;
    }
    static void mostrarVector(int[] v, String nomVector){
        System.out.print(nomVector+"[] = ");
        for (int i = 0; i < v.length; i++) {
            System.out.print(v[i] + " ");
        }
        System.out.println();

      
    }
}
