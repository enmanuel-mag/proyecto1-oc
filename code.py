import random
import numpy as np
print('Bienvenido a sistema de combates de Pokemon')


def batalla(nombre1, nombre2, tipo1, tipo2):
    tipos = getTypeArray('types.txt')
    matriz = obtenerMatrizVentajas('matriz.txt')

    print("Combatientes: {0} vs. {1}".format(nombre1, nombre2))
    nombres = [nombre1, nombre2]

    ataques = np.array([getFactor(tipo1, tipo2, tipos, matriz),
                        getFactor(tipo2, tipo1, tipos, matriz)])

    vida = np.array([5.0, 5.0])

    while (vida[0] > 0) and (vida[1] > 0):
        ataque(0, 1, nombres, vida, ataques)
        if(vida[1] > 0):
            ataque(1, 0, nombres, vida, ataques)

    ganador = vida.argmax()
    print("{0} es el Ganador!".format(nombres[ganador]))


def ataque(p1, p2, nombre, vida, ataques):
    print("{0}: Vida: {1} Ataque:{2} Ataca a {3}: Vida: {4}\tAtaque:{5}".format(
        nombre[p1], vida[p1], ataques[p1], nombre[p2], vida[p2], ataques[p2]))
    vida[p2] = vida[p2]-ataques[p1]
    print()
    print("Resultado del ataque:")
    print("{0}: Vida:{1} Ataque:{2}".format(
        nombre[p1], vida[p1], ataques[p1]))
    print("{0}: Vida:{1} Ataque:{2}".format(
        nombre[p2], vida[p2], ataques[p2]))
    print()


def readFile():
    pokemons = []
    types = []
    with open('pokeTypes.txt', 'r') as file:
        for line in file:
            pokemonName, pokemonType = line.strip().split(',')
            pokemons.append(pokemonName)
            types.append(pokemonType)
    return pokemons, types


def getTenPokemons(allPokemos, allTypes):
    startIndex = random.randint(0, 99)
    endIndex = startIndex + 11
    return allPokemos[startIndex:endIndex], allTypes[startIndex:endIndex]


def start():
    allPokemons, allTypes = readFile()
    pokemons, types = getTenPokemons(allPokemons, allTypes)
    [print(f'{i}.{pokemons[i]}') for i in range(len(pokemons))]
    print('11. Salir')

    numPoke1 = -1
    bool1 = True
    bool2 = True
    while bool1 or bool2:
        # Se valida que sea un sea un numero y no string
        n = int(input('Ingrese un número para el primer pokemon: '))
        if n == 11:
            exit(0)
        bool1 = n < -1
        bool2 = 10 < n

    numPoke1 = n
    numPoke2 = -1
    bool1 = True
    bool2 = True
    while bool1 or bool2:
        # Se valida que sea un sea un numero y no string
        n = int(input('Ingrese un número para el segundo pokemon: '))
        if n == 11:
            exit(0)
        bool1 = n < -1
        bool2 = 10 < n
    numPoke2 = n

    nombrePoke1 = pokemons[numPoke1]
    nombrePoke2 = pokemons[numPoke2]
    tipoPoke1 = types[numPoke1]
    tipoPoke2 = types[numPoke2]

    batalla(nombrePoke1, nombrePoke2, tipoPoke1, tipoPoke2)


def obtenerMatrizVentajas(archivo: str):
    with open(archivo, "r") as f:
        matriz = []
        for line in f:
            matriz.append(line.strip().split(","))
    return np.array(matriz, dtype=float)


def getFactor(atackType, defenseType, arrayTypes, matrixAdv):
    j = list(arrayTypes).index(atackType)
    i = list(arrayTypes).index(defenseType)
    return matrixAdv[i, j]


def getTypeArray(archivo):
    with open(archivo, "r") as f:
        matriz = []
        for line in f:
            matriz.append(line.strip())
    return np.array(matriz)


start()
