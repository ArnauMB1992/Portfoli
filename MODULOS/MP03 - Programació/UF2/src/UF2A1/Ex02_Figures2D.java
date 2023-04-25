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
public class Ex02_Figures2D {
    public static void main(String[] args) {
        Scanner sc= new Scanner(System.in);
        char opcio;
        do{
//            System.out.println("**SELECCIONA FIGURA 2D **");
//            System.out.println("1.Cadrado");
//            System.out.println("2.Rectangulo");
//            System.out.println("3.Triangulo");
//            System.out.println("4.Circulo");
//            System.out.println("\n Tria una opcio[1-4]:");
            
            opcio = sc.nextLine().toUpperCase().charAt(0);
                if(opcio == 'S'){
                    break;
                }
            
        
        double perimetre = 0.0, superficie = 0.0;
        switch(opcio){
            case 'Q':
                //System.out.println("Costat: ");
                System.out.println("==Quadrat==");
                double costat=sc.nextDouble();
                sc.nextLine();
                perimetre = calculaPerimetreCuadrat(costat);
                superficie = calculaSuperficieCuadrat(costat);
                break;
            case 'R':
                //System.out.println("Costat llarg: ");
                double costatLlarg=sc.nextDouble();
                sc.nextLine();
                //System.out.println("Costat curt: ");
                double costatCurt=sc.nextDouble();
                sc.nextLine();
                System.out.println("==Rectangle==");
                perimetre = calculaPerimetreRectangulo(costatLlarg,costatCurt );
                superficie = calculaSuperficieRectangulo(costatLlarg,costatCurt );    
                break;
            case 'T':
                //System.out.println("Base: ");
                double base=sc.nextDouble();
                sc.nextLine();
                //System.out.println("Altura: ");
                double altura=sc.nextDouble();
                sc.nextLine();
                System.out.println("==Triangle isòsceles==");
                perimetre = calculaPerimetreTriangle(base,altura );
                superficie = calculaSuperficieTriangle(base,altura );    
                break;
            case 'C':
                //System.out.println("Radi: ");
                double radi=sc.nextDouble();
                sc.nextLine();
                System.out.println("==Cercle==");
                perimetre = calculaPerimetreCirculo(radi);
                superficie = calculaSuperficieCirculo(radi);
                break;
        }
        System.out.printf("Perímetre : %.2f \n", perimetre);
        System.out.printf("Superfície: %.2f \n", superficie);
    }while(true);
        }
    public static double calculaPerimetreCuadrat(double costat){
        double resultat = costat*4;
        return resultat;
    }
    public static double calculaSuperficieCuadrat(double costat){
        double resultat = costat*costat;
        return resultat;
    }
    public static double calculaPerimetreRectangulo(double costatLlarg,double costatCurt ){
        double resultat = (costatLlarg+costatCurt)*2;
        return resultat;
    }
    public static double calculaSuperficieRectangulo(double costatLlarg,double costatCurt ){
        double resultat = costatLlarg*costatCurt;
        return resultat;
    }
    public static double calculaPerimetreTriangle(double base,double altura ){
        double resultat = base+altura*2;
        return resultat;
    }
    public static double calculaSuperficieTriangle(double base,double altura ){
        double resultat = (base*Math.sqrt(4*altura*altura-base*base))/4;
        return resultat;
    }
    public static double calculaPerimetreCirculo(double radi){
        double resultat = 2*Math.PI*radi;
        return resultat;
    }
    public static double calculaSuperficieCirculo(double radi){
        double resultat = Math.PI*radi*radi;
        return resultat;
    }
}
