% que es una ruta?
% una ruta se define al ruta que existe de un punto 'A' hacia
% un punto 'B', de manera directa; en caso de que no exista la ruta directa,
% se busca una ruta inversa.
% ruta es ruta_directa o ruta_inversa
% ruta_directa V ruta_inversa -> existe_ruta
% existe_ruta <- ruta_directa V ruta_inversa

% existe_ruta es ruta
ruta(Origen, Destino, Distancia) :- ruta_directa(Origen, Destino, Distancia).
ruta(Origen, Destino, Distancia) :- ruta_inversa(Origen, Destino, Distancia).

ruta_directa(argentina, panama, 5512).
ruta_directa(holanda, argentina, 12058).
ruta_directa(usa, colombia, 5001).
ruta_directa(peru, mexico, 4717).
ruta_directa(brasil, alemania, 9600).
ruta_directa(chile, francia, 11700).
ruta_directa(venezuela, reino_unido, 7500).
ruta_directa(bolivia, argentina, 2500).
ruta_directa(mexico, usa, 2000).
ruta_directa(canada, italia, 6500).
ruta_directa(uruguay, brasil, 1500).
ruta_directa(colombia, panama, 800).
ruta_directa(canada, reino_unido, 5700).
ruta_directa(italia, francia, 1100).
ruta_directa(brasil, argentina, 2900).

ruta_inversa(Origen, Destino, Distancia):- ruta_directa(Destino, Origen, Distancia).

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

