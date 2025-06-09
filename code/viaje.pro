%ruta busca la ruta entre dos estados de EE.UU. y su distancia.
ruta(Origen, Destino, Distancia) :-ruta_directa(Origen, Destino, Distancia).
ruta(Origen, Destino, Distancia) :- ruta_inversa(Origen, Destino, Distancia).
ruta_inversa(Origen, Destino, Distancia) :- ruta_directa(Destino, Origen, Distancia).

ruta_directa(california, nevada, 120).
ruta_directa(california, arizona, 140).
ruta_directa(california, texas, 250).
ruta_directa(nevada, utah, 90).
ruta_directa(utah, colorado, 110).
ruta_directa(arizona, new_mexico, 100).
ruta_directa(texas, louisiana, 130).
ruta_directa(texas, oklahoma, 110).
ruta_directa(oklahoma, kansas, 80).
ruta_directa(kansas, missouri, 85).
ruta_directa(missouri, illinois, 70).
ruta_directa(illinois, indiana, 60).
ruta_directa(indiana, ohio, 65).
ruta_directa(ohio, pennsylvania, 90).
ruta_directa(pennsylvania, new_york, 100).
ruta_directa(new_york, new_jersey, 40).
ruta_directa(new_york, massachusetts, 60).
ruta_directa(florida, georgia, 95).
ruta_directa(georgia, south_carolina, 60).
ruta_directa(south_carolina, north_carolina, 50).
ruta_directa(north_carolina, virginia, 70).
ruta_directa(virginia, maryland, 60).
ruta_directa(maryland, delaware, 40).
ruta_directa(delaware, new_jersey, 50).

camino(Origen, Destino, DistanciaTotal, ListaLugares):-
    camino_(Origen, Destino, DistanciaTotal, [Origen], ListaLugares).

% regla auxiliar 'camino_' que se encarga de hacer el 'trabajo sucio' para hallar caminos
% caso base: cuando camino_ es sencillo, osea una ruta de 'A' hacia 'B'
camino_(Origen, Destino, DistanciaTotal, BorradorVisitados, [Origen, Destino]):-
    ruta(Origen, Destino, DistanciaTotal),
    not(member(Destino, BorradorVisitados)).

% caso contrario, debemos buscar un lugar intermedio por donde se puede ir
% hacia el destino final.
camino_(Origen, Destino, DistanciaTotal, BorradorVisitados, [Origen | ListaLugares]):-
    ruta(Origen, LugarIntermedio, DistanciaIntermedia),
    LugarIntermedio \= Destino,
    not(member(LugarIntermedio, BorradorVisitados)), % evita repetir lugares visitados
    camino_(LugarIntermedio, Destino, DistanciaIntermedia2, [LugarIntermedio | BorradorVisitados], ListaLugares),
    DistanciaTotal is DistanciaIntermedia + DistanciaIntermedia2.

mejor_camino(Origen, Destino, DistanciaTotal, ListaLugares):-
    findall((Distancia, Lugares), camino(Origen, Destino, Distancia, Lugares), Caminos),
    sort(Caminos, CaminosOrdenados),
    CaminosOrdenados = [(DistanciaTotal, ListaLugares) | _].

