data {
  int N;
  int<lower=0> tries[N];
  int<lower=0> successes[N];
  real<lower=0> dist[N];
  
  real R;
  real r;
}

parameters {
  real<lower = 0> sigma;
}

model {
  real p[N];
  
  for (n in 1:N) 
    p[n] = 2 * Phi(asin((R - r) / dist[n]) / sigma) - 1;
  
  successes ~ binomial(tries, p);
}

generated quantities {
  vector[N] sucess_predictions;
  for (n in 1:N) {
    real p;
  	p = 2 * Phi(asin((R - r) / dist[n]) / sigma) - 1;
    sucess_predictions[n] = binomial_rng(tries[n], p);
  }
}
