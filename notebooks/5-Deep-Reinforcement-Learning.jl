### A Pluto.jl notebook ###
# v0.19.38

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 8cfaf249-4eae-410c-8f6a-f34c0bbb4cd1
using Pkg

# ╔═╡ c740d81d-aec8-4c4d-8c43-8f90c79804f9
pkg"add https://github.com/ancorso/Crux.jl"

# ╔═╡ 3940e6ed-74ca-479c-967f-eb17369306b5
pkg"add https://github.com/ancorso/POMDPGym.jl"

# ╔═╡ 0524bc29-fce2-4102-8e76-f0dd3ff65d86
Pkg.add("PlutoUI")

# ╔═╡ f9da2459-a6de-4a39-b0ba-e136dc5962e2
Pkg.add("FFMPEG")

# ╔═╡ ae26747f-0f0c-4ef8-887c-a6740da50614
Pkg.add("cuDNN")

# ╔═╡ fcf1e6a8-30a8-48ca-96ce-700d2d88f1a4
Pkg.add("Flux")

# ╔═╡ 9b81b780-0d6e-4dc2-b636-6cb7b26bce1c
begin
	using PlutoUI

	md"""
	# Deep Reinforcement Learning (RL)
	##### Julia Academy: _Decision Making Under Uncertainty with POMDPs.jl_
	
	An quick introduction to _deep reinforcement learning_ using [`Crux`](https://github.com/ancorso/Crux.jl).
	- For more formal information, see Stanford's course _Reinforcement Learning_ available on [YouTube](https://www.youtube.com/playlist?list=PLoROMvodv4rOSOPzutgyCTapiGlY2Nd8u).

	-- Robert Moss (Stanford University) as part of [_Julia Academy_](https://juliaacademy.com/) (Github: [mossr](https://github.com/mossr))
	"""
end

# ╔═╡ 3978f252-76e4-4bcb-b941-98ff22319405
using FFMPEG

# ╔═╡ 7cbda2b8-2818-4820-8091-d4db1b2fd1cf
using POMDPs

# ╔═╡ b17c899c-dc41-4b0a-8b73-8453646bbe74
using Flux

# ╔═╡ 89ae1ce4-614a-4112-8298-82e0af1cdca1
using Crux

# ╔═╡ 361e6e89-d015-4640-9a6d-a65d9be8a691
using POMDPGym

# ╔═╡ 3c534838-4023-4e01-996a-9dc2f5422ed0
md"""
## Deep RL
_Deep reinforcement learning_ combines algorithms from _reinforcement learning_ with techniques from _deep learning_, namely the use of _neural networks_ as function approximators and policies.

The [`Crux`](https://github.com/ancorso/Crux.jl) package implements several deep RL solvers using the `POMDPs.jl` interface and `Flux.jl` for deep learning.
"""

# ╔═╡ 49f62254-2dee-4d8e-a9f6-74618536dd5b


# ╔═╡ 857a1d04-074b-4195-b39d-aa7c4029679c
md"""
## Swinging Pendulum
The _swinging pendulum_ problem is an MDP consisting of a pole fixed at a single point, and control actions apply torque to attempt to balance the pole upright.
"""

# ╔═╡ 1126debb-54b8-441e-b479-13f650984b26
md"""
### Action space (continuous & discrete)
The actions correspond to torque applied in the clockwise and counter-clockwise directions (negative and positive values, respectively).

We use two different action spaces depending on which solution algorithm we choose. One algorithm, called _PPO_, uses a _continuous_ action space defined by a Gaussian with mean zero and unit variance (i.e., variance of one). Actions are then sampled from this policy, represented by a distribution.
"""

# ╔═╡ ce5604b9-fecd-44e2-84ff-a7353ba53170
md"""
The other algorithm, called _DQN_, can only handle a _discrete_ action space. We provide a coarse discretization of five torque values: two clockwise torques ($-2$ and $-0.5$), two counter-clockwise torques ($2$ and $0.5$), and one where no torque is applied ($0$). Details about _why_ we are forced to use a discrete action space when solving with DQN will be discussed below.
"""

# ╔═╡ 6de8bd11-50a6-4148-be10-e2d43f974946
𝒜 = [-2.0, -0.5, 0, 0.5, 2.0];

# ╔═╡ 58579d8b-d51a-445a-a35b-6844497c1b29
md"""
### State space (continuous)
A state value is the real-valued angle $\theta$ and the angular velocity $\omega$ of the pole:

$$s = (\theta, \omega)$$

The _continuous_ state space is represented as two independent Gaussian (normal) distributions with mean zero and unit variance (i.e., variance of one).
"""

# ╔═╡ 9a0ed9f7-c0e6-427c-bbad-7ab664d0a259
md"""
### MDP definition
We use the `PendulumMDP` defined in the [`POMDPGym`](https://github.com/ancorso/POMDPGym.jl) package that wraps Open AI's [gym](https://gym.openai.com/envs/#classic_control) environments but also implements some Julia-only gym-like environments (where the pendulum is an example of one such environment).
"""

# ╔═╡ f679c89e-be33-4f65-90f3-b9954c9bcb44
mdp = PendulumMDP(actions=𝒜);

# ╔═╡ 407d6c14-c658-4de8-addb-98b8e7e501b3
render(mdp, [0.1, 0], -1.0)

# ╔═╡ 807d88a4-3a98-4130-8f7d-68db328c8ebb
𝒮 = state_space(mdp)

# ╔═╡ 14635bd8-e0b7-4842-b6ec-70974041836e
md"""
## Actor-Critic Methods
_Actor-critic methods_ use an estimate of the value function to help optimize the policy directly.$^1$ Here, the _actor_ is the policy itself and the _critic_ is the value function.

It is called an "actor" because it takes actions using a policy and a "critic" because it evaluates those actions using the value function.$^2$
"""

# ╔═╡ 62787bbd-35a4-4820-b42e-6a7877a2d97b
Resource("http://incompleteideas.net/book/first/ebook/figtmp34.png")

# ╔═╡ d2e070f2-4c9a-4418-9679-9e22eb111766
md"""
### Actor
The _actor_ is represented as a Gaussian policy where the mean is approximated by a neural network.
"""

# ╔═╡ cac137cb-8c1a-4662-b864-91ab65585c06
function action_network()
	layer1 = Dense(2, 64, relu)
	layer2 = Dense(64, 64, relu)
	layer3 = Dense(64, 1, tanh)
	layer4 = x -> 2f0 * x
	return ContinuousNetwork(Chain(layer1, layer2, layer3, layer4), 1)
end

# ╔═╡ 0edf8c48-b522-4d02-8964-2b8f219545d1
actor() = GaussianPolicy(action_network(), zeros(Float32, 1))

# ╔═╡ 70b36b02-6501-49ca-8f80-9841a989129c
md"""
### Critic
The _critic_ is represented as a neural network that estimates the _advantage_ $A(s,a)$, which quantifies the advantage of a specific action $a$ over the greedy action (i.e., comparing their values):$^1$

$$\begin{align}
A(s,a) &= Q(s,a) - U(s)\\
       &= Q(s,a) - \max_{a \in \mathcal{A}} Q(s,a)
\end{align}$$
"""

# ╔═╡ 0d2cbd97-3cd8-4753-8df5-9617f35905ae
function critic()
	layer1 = Dense(2, 64, relu)
	layer2 = Dense(64, 64, relu)
	layer3 = Dense(64, 1)
	return ContinuousNetwork(Chain(layer1, layer2, layer3))
end

# ╔═╡ c40594c2-e50b-4e2b-8808-65ea67c6994a
md"""
### Actor-Critic Policy
The `ActorCritic` policy combines the _actor_ and _critic_ so when we want to get _utilities_ (or _values_) from a state we use the _critic_, and when we want to get actions from a state we use the _actor_. This object will be trained when we call `solve` (i.e., the weights of the internal neural networks will change).
"""

# ╔═╡ c7e9c6fc-04fc-4fc8-84d8-2af6b6d7a3e0
π_actor_critic = ActorCritic(actor(), critic());

# ╔═╡ e40c16c7-d186-46b6-b2b6-ee4806abd10c
md"""
### Solver: Proximal Policy Optimization (PPO)
The _proximal policy optimization_ (PPO) algorithm is a deep reinforcement learning algorithm that implements trust regions (i.e., enforced improvement).$^3$ PPO is an _on-policy_ algorithm—meaning that during training, we learn from actions taken from the **same** policy that we're training.$^2$
"""

# ╔═╡ 4e86c512-f2a3-49f2-b466-1bd2284fa4f8
solver_ppo = PPO(π=π_actor_critic, S=𝒮, N=100000, ΔN=2048, a_opt=(batch_size=512,));

# ╔═╡ 75d226b6-9012-4a4f-abec-785adbd70c0d
action_space(solver_ppo.π)

# ╔═╡ 30733eae-e687-41bd-ba93-ae7668f08b54
md"""
Now we can solve for an approximately optimal policy of the pendulum MDP!

> **Note, this will run in the background so check the Pluto terminal for training information.**
"""

# ╔═╡ 8d1597cd-13b7-4c7c-bc00-2e8930a5e4cd
policy_ppo = solve(solver_ppo, mdp)

# ╔═╡ a9f930f6-3f47-46cf-b16e-f1ca8eb0ff9a
begin
	!isdir("gifs") && mkdir("gifs") # create "gifs" directory
	gif(mdp, policy_ppo, "gifs/pendulum_ppo.gif", max_steps=200)
	isfile("gifs/pendulum_ppo.gif") && LocalResource("./gifs/pendulum_ppo.gif")
end

# ╔═╡ 49be2cdc-7b16-4e9c-9027-e0d3a11326c0
md"""
## Deep Q-Network (DQN)
The _deep Q-learning_ algorithm uses a _deep Q-network_ (DQN) as a state-action value function approximator and introduced _experience replay_ and a _target network_ (the `Q_network` in this case) to mitigate previously unstable approaches.$^4$ 
"""

# ╔═╡ bb01e9d7-6ea2-462d-af1b-7a1ad8a070a4
md"""
### Target network
The _target network_ is used in the _off-policy_ setting—meaning that during training, the policy used to select actions is **different** than the policy that is being improved.$^2$ 

The _Q-network_ is a discrete network because it approximates $Q(s,a)$ for each discrete action $a \in \mathcal{A}$ and to select an action it must perform an $\operatorname{argmax}$ over all possible actions (which is not well-defined for continous actions):

$$\pi_\text{DQN}(s) = \operatorname*{argmax}_{a \in \mathcal{A}} Q(s, a)$$
"""

# ╔═╡ 0f1966e5-06d5-4682-8468-f6d116cd8d9a
function Q_network()
	layer1 = Dense(2, 64, relu)
	layer2 = Dense(64, 64, relu)
	layer3 = Dense(64, length(𝒜))
	return DiscreteNetwork(Chain(layer1, layer2, layer3), 𝒜)
end

# ╔═╡ ff38b524-1e70-4e39-8661-498c4c95a0d9
md"""
### Solver: DQN
We construct the DQN solver using the Q-network as our policy.
"""

# ╔═╡ 27b845dd-c6bf-4cee-9c30-05a2f4679499
solver_dqn = DQN(π=Q_network(), S=𝒮, N=30000);

# ╔═╡ 61fe850f-02f8-4fbd-93b0-e35f71129d21
action_space(solver_dqn.π)

# ╔═╡ 0baf5fb6-a772-4bef-a31f-880db9e43736
md"""
Then we can solve for an approximately optimal policy.

> **Note, this will run in the background so check the Pluto terminal for training information.**
"""

# ╔═╡ 24d6d1da-74df-4611-bc74-3dd8ae6d9149
policy_dqn = solve(solver_dqn, mdp)

# ╔═╡ 8ecd98b0-5df1-4d31-9af5-0737f46f4819
begin
	gif(mdp, policy_dqn, "gifs/pendulum_dqn.gif", max_steps=200)
	isfile("gifs/pendulum_dqn.gif") && LocalResource("./gifs/pendulum_dqn.gif")
end

# ╔═╡ 506d537c-36c0-491b-9dc0-c404b7365796
md"""
## Plotting Performance
We can use the `plot_learning` function to show the training curves of PPO and DQN.
"""

# ╔═╡ 530ddcd0-56be-49d0-ac19-2d1ac26d860a
plot_learning([solver_ppo, solver_dqn],
	title="Pendulum Swingup Training Curves",
	labels=["PPO", "DQN"],
	legend=:right)

# ╔═╡ 92ff7f03-bb32-450f-a131-46af1fc9cb61
md"""
## Comparing Actions
Now lets sweep through the angle $\theta$ portion of the state space and see what action each policy takes.
"""

# ╔═╡ 803cfb34-10ab-4f78-b065-8688a0cda029
md"""
#### PPO Policy vs. DQN Policy
Continous actions (PPO) and discrete actions (DQN).
"""

# ╔═╡ 7b65e902-dc0c-4d02-a22d-673ecbb864db
md"θ: $(@bind θ Slider(-π:0.01:π, default=0, show_value=true)) | ω: $(@bind ω Slider(-1:0.01:1, default=0, show_value=true))"

# ╔═╡ 5fc9de70-b728-4b57-85ee-10fd993a1120
s = [θ, ω]

# ╔═╡ 95d535c1-f253-44bd-8576-2ea490f09292
a_ppo, a_dqn = action(policy_ppo, s), action(policy_dqn, s)

# ╔═╡ f28bdcb8-6969-41c0-a1e7-daf6db1882c4
[render(mdp, s, a_ppo) render(mdp, s, a_dqn)]

# ╔═╡ 66cf354f-df0e-47ec-8a96-93241157981d
md"""
## References
1. Mykel J. Kochenderfer, Tim A. Wheeler, and Kyle H. Wray, "Algorithms for Decision Making", *MIT Press*, 2022. [https://algorithmsbook.com](https://algorithmsbook.com)

2. Richard S. Sutton and Andrew G. Barto, "Reinforcement Learning: An Introduction", *MIT Press*, 2020. [http://incompleteideas.net/book/the-book.html](http://incompleteideas.net/book/the-book.html)

3. John Schulman, et al. "Proximal Policy Optimization Algorithms." arXiv:1707.06347,  2017. [https://arxiv.org/pdf/1707.06347.pdf](https://arxiv.org/pdf/1707.06347.pdf)

4. V. Mnih, K. Kavukcuoglu, D. Silver, A. A. Rusu, J. Veness, M. G. Bellemare, et al., "Human-Level Control Through Deep Reinforcement Learning," Nature, vol. 518, no. 7540, pp. 529–533, 2015.

"""

# ╔═╡ f6d7f526-5b53-44c5-a004-43ff5907735c
TableOfContents(title="Deep RL", depth=4)

# ╔═╡ 755cb946-3a8e-4b3e-9c6f-8c8f137816f0
md"""
---
"""

# ╔═╡ 17c30d7f-ac45-40b2-af4b-1c70e9a5a65c
html"""
<script>
var section = 0;
var subsection = 0;
var headers = document.querySelectorAll('h2, h3');
for (var i=0; i < headers.length; i++) {
    var header = headers[i];
    var text = header.innerText;
    var original = header.getAttribute("text-original");
    if (original === null) {
        // Save original header text
        header.setAttribute("text-original", text);
    } else {
        // Replace with original text before adding section number
        text = header.getAttribute("text-original");
    }
    var numbering = "";
    switch (header.tagName) {
        case 'H2':
            section += 1;
            numbering = section + ".";
            subsection = 0;
            break;
        case 'H3':
            subsection += 1;
            numbering = section + "." + subsection;
            break;
    }
    header.innerText = numbering + " " + text;
};
</script>
"""

# ╔═╡ Cell order:
# ╠═8cfaf249-4eae-410c-8f6a-f34c0bbb4cd1
# ╠═0524bc29-fce2-4102-8e76-f0dd3ff65d86
# ╠═9b81b780-0d6e-4dc2-b636-6cb7b26bce1c
# ╟─3c534838-4023-4e01-996a-9dc2f5422ed0
# ╠═f9da2459-a6de-4a39-b0ba-e136dc5962e2
# ╠═3978f252-76e4-4bcb-b941-98ff22319405
# ╠═49f62254-2dee-4d8e-a9f6-74618536dd5b
# ╠═c740d81d-aec8-4c4d-8c43-8f90c79804f9
# ╠═ae26747f-0f0c-4ef8-887c-a6740da50614
# ╠═7cbda2b8-2818-4820-8091-d4db1b2fd1cf
# ╠═fcf1e6a8-30a8-48ca-96ce-700d2d88f1a4
# ╠═b17c899c-dc41-4b0a-8b73-8453646bbe74
# ╠═89ae1ce4-614a-4112-8298-82e0af1cdca1
# ╟─857a1d04-074b-4195-b39d-aa7c4029679c
# ╠═407d6c14-c658-4de8-addb-98b8e7e501b3
# ╟─1126debb-54b8-441e-b479-13f650984b26
# ╠═75d226b6-9012-4a4f-abec-785adbd70c0d
# ╟─ce5604b9-fecd-44e2-84ff-a7353ba53170
# ╠═6de8bd11-50a6-4148-be10-e2d43f974946
# ╠═61fe850f-02f8-4fbd-93b0-e35f71129d21
# ╟─58579d8b-d51a-445a-a35b-6844497c1b29
# ╠═807d88a4-3a98-4130-8f7d-68db328c8ebb
# ╟─9a0ed9f7-c0e6-427c-bbad-7ab664d0a259
# ╠═3940e6ed-74ca-479c-967f-eb17369306b5
# ╠═361e6e89-d015-4640-9a6d-a65d9be8a691
# ╠═f679c89e-be33-4f65-90f3-b9954c9bcb44
# ╟─14635bd8-e0b7-4842-b6ec-70974041836e
# ╠═62787bbd-35a4-4820-b42e-6a7877a2d97b
# ╟─d2e070f2-4c9a-4418-9679-9e22eb111766
# ╠═cac137cb-8c1a-4662-b864-91ab65585c06
# ╠═0edf8c48-b522-4d02-8964-2b8f219545d1
# ╟─70b36b02-6501-49ca-8f80-9841a989129c
# ╠═0d2cbd97-3cd8-4753-8df5-9617f35905ae
# ╟─c40594c2-e50b-4e2b-8808-65ea67c6994a
# ╠═c7e9c6fc-04fc-4fc8-84d8-2af6b6d7a3e0
# ╟─e40c16c7-d186-46b6-b2b6-ee4806abd10c
# ╠═4e86c512-f2a3-49f2-b466-1bd2284fa4f8
# ╟─30733eae-e687-41bd-ba93-ae7668f08b54
# ╠═8d1597cd-13b7-4c7c-bc00-2e8930a5e4cd
# ╠═a9f930f6-3f47-46cf-b16e-f1ca8eb0ff9a
# ╟─49be2cdc-7b16-4e9c-9027-e0d3a11326c0
# ╟─bb01e9d7-6ea2-462d-af1b-7a1ad8a070a4
# ╠═0f1966e5-06d5-4682-8468-f6d116cd8d9a
# ╟─ff38b524-1e70-4e39-8661-498c4c95a0d9
# ╠═27b845dd-c6bf-4cee-9c30-05a2f4679499
# ╟─0baf5fb6-a772-4bef-a31f-880db9e43736
# ╠═24d6d1da-74df-4611-bc74-3dd8ae6d9149
# ╠═8ecd98b0-5df1-4d31-9af5-0737f46f4819
# ╟─506d537c-36c0-491b-9dc0-c404b7365796
# ╠═530ddcd0-56be-49d0-ac19-2d1ac26d860a
# ╟─92ff7f03-bb32-450f-a131-46af1fc9cb61
# ╟─803cfb34-10ab-4f78-b065-8688a0cda029
# ╠═95d535c1-f253-44bd-8576-2ea490f09292
# ╠═f28bdcb8-6969-41c0-a1e7-daf6db1882c4
# ╠═5fc9de70-b728-4b57-85ee-10fd993a1120
# ╟─7b65e902-dc0c-4d02-a22d-673ecbb864db
# ╟─66cf354f-df0e-47ec-8a96-93241157981d
# ╠═f6d7f526-5b53-44c5-a004-43ff5907735c
# ╟─755cb946-3a8e-4b3e-9c6f-8c8f137816f0
# ╟─17c30d7f-ac45-40b2-af4b-1c70e9a5a65c
