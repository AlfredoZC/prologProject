from pyswip import Prolog

prolog = Prolog()
prolog.consult("mapa.pl")

def obtener_mejor_ruta(origen, destino):
    consulta = f"mejor_camino({origen}, {destino}, D, R)"
    resultados = list(prolog.query(consulta))
    return resultados[0] if resultados else None

def obtener_todas_las_rutas(origen, destino):
    consulta = f"findall([D, R], camino({origen}, {destino}, D, R), Resultados)"
    resultados = list(prolog.query(consulta))
    return resultados[0]["Resultados"] if resultados else []

