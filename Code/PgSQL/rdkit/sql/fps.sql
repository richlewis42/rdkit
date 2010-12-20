SELECT dice_sml(rdkit_fp('c1ccccc1'::mol),rdkit_fp('c1ccncc1'::mol));
SELECT dice_sml(atompair_fp('c1ccccc1'::mol),atompair_fp('c1ccncc1'::mol));
SELECT dice_sml(torsion_fp('c1ccccc1'::mol),torsion_fp('c1ccncc1'::mol));

SET rdkit.tanimoto_threshold = 0.4;
SELECT
    id, tanimoto_sml(rdkit_fp('O=C1CC(OC2=CC=CC=C12)C1=CC=CC=C1'::mol), f) AS sml
FROM
pgbfp
WHERE rdkit_fp('O=C1CC(OC2=CC=CC=C12)C1=CC=CC=C1'::mol) % f
ORDER BY sml DESC, id LIMIT 10;

SET rdkit.tanimoto_threshold = 0.5;
SET rdkit.dice_threshold = 0.5;

SELECT
    id, dice_sml(torsion_fp('O=C1CC(OC2=CC=CC=C12)C1=CC=CC=C1'::mol), f) AS sml
FROM
pgtorsfp
WHERE torsion_fp('O=C1CC(OC2=CC=CC=C12)C1=CC=CC=C1'::mol) # f
ORDER BY sml DESC, id;

SELECT
    id, dice_sml(atompair_fp('O=C1CC(OC2=CC=CC=C12)C1=CC=CC=C1'::mol), f) AS sml
FROM
pgpairfp
WHERE atompair_fp('O=C1CC(OC2=CC=CC=C12)C1=CC=CC=C1'::mol) # f
ORDER BY sml DESC, id LIMIT 10;
