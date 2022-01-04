# -*- coding: utf-8 -*-
"""Cryptographie

TRAN-THUONG Tien-Thinh MP* Lycée Hoche \\
5 Janvier 2022

# Importation
"""

import random, hashlib, math
import sympy.ntheory as nt

"""# RSA

## Fonctions Utiles
"""

def pgcd(a, b): # PGCD de a et b
    if a==0:
        return b
    else:
        return pgcd(b%a, a)

def exp(a, n, mod): # exponentielle modulo n
    a_ = (a*a)%mod
    if n==0:
        return 1
    elif n%2 == 1:
        return (a* exp(a_, n//2, mod)) % mod
    else:
        return exp(a_, n//2, mod) % mod

def c_bezout(a, b): # Renvoie le couple de bezout
    if a==0:
        return 0, 1
    else:
        x, y = c_bezout(b%a, a)
        return y-(x*(b//a)), x

"""## Calculs des clés"""

def calcul_cles(p, q): # Renvoie une clé aléatoire avec n = pq
    n = p*q
    w = (p-1)*(q-1)

    e = random.randint(2, w)
    while pgcd(e, w)!=1:
        e = random.randint(2, w)

    d, _ = c_bezout(e, w)
    d = d % w
    return (
        (e, n), # clé publique
        (d, n)  # clé privée
    )

def chiffrer(m, e, n): # dechiffrer c'est chiffrer avec la clé (d, n)
    return exp(m, e, n)

"""## Test sur des chiffres"""

(e, n), (d, _) = calcul_cles(23, 17)
e, d, n

m = 123
m_chiffre = chiffrer(m, e, n)
print(m_chiffre)

print(chiffrer(m_chiffre, d, n))

"""## Test avec du TEXT"""

def list_vers_str(l): # Transforme une liste de caractères en str
    return "".join(l)

def ASCII(m): # Renvoie la liste de code ASCII d'un mot
    return [ord(x) for x in m]

def ASCII_rev(L): # Renvoie le mot associé à une liste de code ASCII
    return list_vers_str([chr(x) for x in L])

def chiffrer_list(L, e, n): # Chiffre une liste de nombre
    return [chiffrer(x, e, n) for x in L]

def chiffrer_message(m, e, n): # Chiffre un mot
    L = ASCII(m)
    L_chiffre = chiffrer_list(L, e, n)
    m_chiffre = ASCII_rev(L_chiffre)
    return m_chiffre


message = "Hello World !"
m_chiffre = chiffrer_message(message, e, n)
print(m_chiffre)

print(chiffrer_message(m_chiffre, d, n)) # déchiffrage



"""## Signature"""

p = 1336960567662962283753869307762637651931440981
q = 75653091714058546859351538667868792577806729
print(nt.isprime(p), nt.isprime(q))

(e_BOB, n_BOB), (d_BOB, _) = calcul_cles(p, q) # Création des clés de BOB
print(f"{e_BOB}\n{d_BOB}\n{n_BOB}")

def H256(x): # Hachage d'un mot avec sha 256
    binaire = str(x).encode("ASCII")
    Hash_hex = hashlib.sha256(binaire).hexdigest()
    return int(Hash_hex, 16)

m = "Hello World !"
print(m)
hash = H256(m)
print(hash)

hash_chiffre = chiffrer(hash, d_BOB, n_BOB)
print(hash_chiffre)

hash_dechiffre = chiffrer(hash_chiffre, e_BOB, n_BOB)
print(hash_dechiffre)

hash == hash_dechiffre

"""# Tests de primalité

## Méthode naïve (déterministe)
"""

def est_premier(n): # test si un nombre est premier
    for x in range(2, int(math.sqrt(n)+1)):
        if n%x == 0:
            return False
    return True

def gen_liste(f, n, *args): # Génère avec f la liste des premiers de [2, n]
    return [p for p in range(2, n) if f(p, *args)]

print(gen_liste(est_premier, 100))

"""## Crible d'Erathostene (déterministe)"""

def erathostene(n): # Renvoie les premiers de [2, n]
    L = [i for i in range(n, 1, -1)] # [n, n-1, ..., 3, 2]
    resultat = []
    while L!=[]:
        p = L.pop()
        resultat.append(p)
        L = [x for x in L if x%p != 0]
    return resultat
print(erathostene(100))

# L = erathostene(500_000) # 1 minute 56 secondes
# len(L) # 41538


"""## Test de Primalité de Fermat (probabiliste)
Pour la base 2, il a seulement 2183 faux positifs quand on teste jusqu'à, 25 milliards. \\
Avec PGP, jusqu'à 500 000 il n'y a eu que 13 faux positifs sur les 41 551 nombres premiers trouvés,
soit un taux de bonnes réponses de 99.969%.
"""

def test_fermat_PGP(p): # Test Pretty Good privacy
    if p in [2, 3, 5, 7]:
        return True
    for a in [2, 3, 5, 7]:
        if exp(a, (p-1), p) != 1:
            return False
    return True

def gen_fermat_PGP(n):
    return [p for p in range(2, n) if test_fermat_PGP(p)]

L_ = gen_liste(test_fermat_PGP, 500_000) # 5 secondes
print(len(L_))

# print(f"Taux de bonnes réponses : {round(100*(1-(len(L_)-len(L))/len(L_)), 3)}%")

def test_fermat(p, k): # Test de Fermat PGP + base aléatoire
    if not test_fermat_PGP(p):
        return False
    for _ in range(k-4):
        a = random.randint(1, p-1)
        if exp(a, (p-1), p) != 1:
            return False
    return True

L_ = gen_liste(test_fermat, 500_000, 10) # 25 secondes
print(len(L_))

def gen_liste_premiers(f, maxi, n, *args): # Renvoie n premiers dans [2, maxi]
    L = []
    while len(L) < n:
        p = random.randint(2, maxi)
        if f(p, *args):
            L.append(p)
    return L

L = gen_liste_premiers(test_fermat, 2**256, 2, 54)
print(L)

[nt.isprime(x) for x in L]

"""## Test de primalité de Miller-Rabin (probabiliste)"""

def calcul_d_s(n): # Variables d, s tq n = d * 2^s
    if n%2 == 1:
        return n, 0 # = d, s
    else:
        d, s = calcul_d_s(n//2)
        return d, s+1

def test_MR(d, s, n): # Test de Miller Rabin
    a = random.randint(1, n - 1)
    x = exp(a, d, n)
    if (x == 1 or x == n - 1):
        return True
    for i in range(s-1):
        x = (x * x) % n
        if (x == 1):
            return False
        if (x == n - 1):
            return True
    return False

def test_MR_kfois(n, k): # Exécuter le test plusieur fois
    d, s = calcul_d_s(n-1)
    for _ in range(k):
        if not test_MR(d, s, n):
            return False
    return True

L = gen_liste(test_MR_kfois, 500_000, 2) # 6 secondes
print(len(L))

L = gen_liste_premiers(test_MR_kfois, 2**256, 2, 2)
print(L)
print([nt.isprime(x) for x in L])


"""# Algorithme de factorisation"""

def facto(n): # Factoriser un nombre
    if n == 1:
        return [1]
    elif test_MR_kfois(n, 10):
        return [n]
    for x in range(2, int(n**0.5)+1):
        if n % x == 0:
            return [x] + facto(n//x)
    return [n]
n = random.getrandbits(32)
print(n)
print(f"La décomposition de {n} est {facto(n)}")






