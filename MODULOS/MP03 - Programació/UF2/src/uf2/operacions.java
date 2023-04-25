/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package uf2;

/**
 *
 * @author ArnauMB
 */
public class operacions {
    public static void main(String[] args) {
        int a = 5;
        int b = 7;
        int c = suma(a,b);
        System.out.printf("La suma de %d i %d es \n", a,b,c);
        
        double d= 3.5;
        double e= 2.1;
        double f= multiplicacio(d,e);
        System.out.printf("La multiplicacio de %.1f i %.1f es %.1f\n", d,e,f);
        
        a=3;
        b=8;
        c=2;
        int max=maxim(a,b,c);
        System.out.printf("El maxim de %d, %d i %d es %d\n",a,b,c,max);
        
    }
    public static int suma(int x, int y){
        int z = x + y;
        return z;
    }
    public static double multiplicacio(double x, double y){
        double z=x*y;
        return z;
    }
    public static int maxim(int a, int b, int c){
        int max;
        if (a>b){
            max = (a>c)?a:c;
//            if (a>c){
//                max=a;
//            }else{
//                max=c;
//            }
        }else{
            max = (b>c)?b:c;
        }
//            if (b>c){
//                max=b;
//            }else{
//                max=c;
//            }
//        }
    return max;
    }    
    
}
