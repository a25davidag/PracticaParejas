public class Main {
    public static void main(String[] args) {
        System.out.println("Bienvenido");


        Producto p = new Producto("Café ultra premium de oficina");
        p.mostrarInfo();

        Usuario u = new Usuario();
        u.nombre = "David";
        u.mostrarInformacion();

    }
}