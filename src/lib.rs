#[cfg(test)]
mod tests {
    use ff::Field;
    use generic_array::typenum::U2;
    use neptune::poseidon::Poseidon;
    use neptune::poseidon::PoseidonConstants;
    use pasta_curves::Fp;

    #[test]
    fn hash_example() {
        let constants: PoseidonConstants<Fp, U2> = PoseidonConstants::new();

        let mut poseidon = Poseidon::<Fp, U2>::new(&constants);

        poseidon
            .input(Fp::from(u64::MAX))
            .expect("can't add one more element");

        let digest = poseidon.hash();

        assert_ne!(digest, Fp::ZERO); // digest has `Fp` type
    }
}
