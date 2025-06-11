import tkinter as tk
from grafo_config import posiciones
from logica import obtener_mejor_ruta, obtener_todas_las_rutas

ventana = tk.Tk()
ventana.title("Rutas entre Estados")
canvas = tk.Canvas(ventana, width=1100, height=650, bg="white")
canvas.pack()

# Dibujar nodos
nodos = {}

for estado, (x, y) in posiciones.items():
    nodos[estado] = canvas.create_oval(x-15, y-15, x+15, y+15, fill="lightblue")
    canvas.create_text(x, y, text=estado, font=("Arial", 8), anchor="s")

# Crear líneas para las conexiones (mismo orden que mapa.pl)
conexiones = [
    ("california", "nevada"), ("california", "arizona"), ("california", "texas"),
    ("nevada", "utah"), ("utah", "colorado"), ("arizona", "new_mexico"),
    ("texas", "louisiana"), ("texas", "oklahoma"), ("oklahoma", "kansas"),
    ("kansas", "missouri"), ("missouri", "illinois"), ("illinois", "indiana"),
    ("indiana", "ohio"), ("ohio", "pennsylvania"), ("pennsylvania", "new_york"),
    ("new_york", "new_jersey"), ("new_york", "massachusetts"), ("florida", "georgia"),
    ("georgia", "south_carolina"), ("south_carolina", "north_carolina"),
    ("north_carolina", "virginia"), ("virginia", "maryland"),
    ("california", "utah"), ("nevada", "arizona"),
    ("maryland", "delaware"), ("delaware", "new_jersey")
]
lineas = {}
for a, b in conexiones:
    x1, y1 = posiciones[a]
    x2, y2 = posiciones[b]
    lineas[(a, b)] = canvas.create_line(x1, y1, x2, y2, fill="gray")

# Función para iluminar caminos
def iluminar_ruta(ruta, color="red"):
    for i in range(len(ruta)-1):
        a, b = ruta[i], ruta[i+1]
        linea = lineas.get((a, b)) or lineas.get((b, a))
        if linea:
            canvas.itemconfig(linea, fill=color, width=3)

def reset_rutas():
    for linea in lineas.values():
        canvas.itemconfig(linea, fill="gray", width=1)

# Entradas y botones
frame = tk.Frame(ventana)
frame.pack()

tk.Label(frame, text="Origen:").grid(row=0, column=0)
entry_origen = tk.Entry(frame)
entry_origen.grid(row=0, column=1)

tk.Label(frame, text="Destino:").grid(row=1, column=0)
entry_destino = tk.Entry(frame)
entry_destino.grid(row=1, column=1)

salida = tk.Text(ventana, height=8, width=80)
salida.pack()

def buscar_todas():
    salida.delete("1.0", tk.END)
    reset_rutas()
    origen = entry_origen.get()
    destino = entry_destino.get()
    rutas = obtener_todas_las_rutas(origen, destino)
    print("DEBUG rutas:", rutas)

    if not rutas:
        salida.insert(tk.END, "No se encontraron rutas.\n")
    for d, r in rutas:
        salida.insert(tk.END, f"Ruta: {r}, Costo: {d}\n")
        iluminar_ruta(r, color="blue")

def buscar_mejor():
    salida.delete("1.0", tk.END)
    reset_rutas()
    origen = entry_origen.get()
    destino = entry_destino.get()
    resultado = obtener_mejor_ruta(origen, destino)
    if not resultado:
        salida.insert(tk.END, "No se encontró ruta óptima.\n")
        return
    d, r = resultado["D"], resultado["R"]
    salida.insert(tk.END, f"Mejor ruta: {r}, Costo total: {d}\n")
    iluminar_ruta(r, color="red")

tk.Button(frame, text="Buscar todas las rutas", command=buscar_todas).grid(row=2, column=0, pady=10)
tk.Button(frame, text="Buscar mejor ruta", command=buscar_mejor).grid(row=2, column=1)

ventana.mainloop()
