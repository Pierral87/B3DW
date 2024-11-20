-- UNION permet de fusionner des résultats en un seul 
-- ATTENTION le nombre de champs attendus doit être la même dans les deux requêtes ! 
-- UNION applique automatiquement un DISTINCT par défaut pour ne pas avoir de doublons de résultats 
SELECT prenom AS "liste de personnes" FROM abonne 
UNION 
SELECT auteur FROM livre;
+--------------------+
| liste de personnes |
+--------------------+
| Guillaume          |
| Benoit             |
| Chloe              |
| Laura              |
| Pierra             |
| GUY DE MAUPASSANT  |
| HONORE DE BALZAC   |
| ALPHONSE DAUDET    |
| ALEXANDRE DUMAS    |
+--------------------+

-- Si je veux les doublons
-- UNION ALL
SELECT prenom AS "liste de personnes" FROM abonne 
UNION ALL
SELECT auteur FROM livre;
+--------------------+
| liste de personnes |
+--------------------+
| Guillaume          |
| Benoit             |
| Chloe              |
| Laura              |
| Pierra             |
| GUY DE MAUPASSANT  |
| GUY DE MAUPASSANT  |
| HONORE DE BALZAC   |
| ALPHONSE DAUDET    |
| ALEXANDRE DUMAS    |
| ALEXANDRE DUMAS    |
+--------------------+