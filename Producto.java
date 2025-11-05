public class Producto {

    // Atributo: nombre del producto
    private String nombre;

    // Constructor
    public Producto(String nombre) {
        this.nombre = nombre;
    }

    // Método que muestra información del producto
    public void mostrarInfo() {
        System.out.println("Producto: " + nombre);
    }
}