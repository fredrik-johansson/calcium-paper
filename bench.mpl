idftdft := proc(coefficients)
    local N, unityroots, dft, idft, zeroes, result;
    N := nops(coefficients);
    unityroots := [seq(exp(I*2*Pi*k/N), k in 0..N-1)];
    dft := [ seq( add(coefficients[1+k]*unityroots[1+(k*n mod N)],
                      k in 0..N-1),
                  n in 0..N-1) ];
    idft := [ seq( add(dft[1+k]*unityroots[1+(-k*n mod N)],
                      k in 0..N-1)/N,
                  n in 0..N-1) ];
    zeroes := map(simplify, coefficients - idft):
    result := andmap(`=`, zeroes, 0);
    printnonzero(zeroes);
    return result;
end proc:

printnonzero := proc(L)
    local k;
    if not andmap(`=`, L, 0) then
        for k from 1 to nops(L) do
            if not evalb(L[k] = 0) then
                print(k, L[k]);
            end if;
        end do;
    end if;
end proc:

bench := proc(f, N)
    local coefficients, st, check, timing;
    forget(..); # Does not clear enough cache data
    lprint(f, N);
    coefficients := [seq(f(n), n in 0..N-1)];
    st := time():
    check := idftdft(coefficients);
    timing := time() - st;
    lprint(check);
    printf("%.3f\n\n",timing);
end proc:

#bench(n -> n+2, 6):
#bench(n -> n+2, 8):
#bench(n -> n+2, 16):
#bench(n -> n+2, 20):
#bench(n -> n+2, 100):

#bench(n -> sqrt(n+2), 6):
#bench(n -> sqrt(n+2), 8):
#bench(n -> sqrt(n+2), 16):
#bench(n -> sqrt(n+2), 20):
#bench(n -> sqrt(n+2), 100): # more than 60 seconds

#bench(n -> log(n+2), 6):
#bench(n -> log(n+2), 8):
#bench(n -> log(n+2), 16):
#bench(n -> log(n+2), 20):
#bench(n -> log(n+2), 100): # more than 60 seconds

#bench(n -> exp(2*Pi*I/(n+2)), 6):
#bench(n -> exp(2*Pi*I/(n+2)), 8):
#bench(n -> exp(2*Pi*I/(n+2)), 16):
#bench(n -> exp(2*Pi*I/(n+2)), 20):
#bench(n -> exp(2*Pi*I/(n+2)), 100): # more than 60 seconds

#bench(n -> 1/(1-(n+2)*Pi), 6):
#bench(n -> 1/(1-(n+2)*Pi), 8):
#bench(n -> 1/(1-(n+2)*Pi), 16):
#bench(n -> 1/(1-(n+2)*Pi), 20):
#bench(n -> 1/(1-(n+2)*Pi), 100): # more than 60 seconds

bench(n -> 1/(1+sqrt(n+2)*Pi), 6):
bench(n -> 1/(1+sqrt(n+2)*Pi), 8):
#bench(n -> 1/(1+sqrt(n+2)*Pi), 16): # more than 60 seconds
bench(n -> 1/(1+sqrt(n+2)*Pi), 20):
# bench(n -> 1/(1+sqrt(n+2)*Pi), 100):

