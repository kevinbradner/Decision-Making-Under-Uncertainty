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

# ╔═╡ 34582cc5-e9eb-4912-9caf-b516b4b9b221
using Pkg

# ╔═╡ 964ff5fa-444f-4095-9e2b-815dc4a68603
pkg"add https://github.com/ancorso/Crux.jl"

# ╔═╡ 004510b7-64d1-47ed-b348-7161af733c01
Pkg.add("Debugger")

# ╔═╡ 60ce9e30-6245-476b-be8d-838e29bc46f9
Pkg.add("POMDPModels")

# ╔═╡ 4c0e7b16-b878-4a9f-a0cc-9448c311f015
Pkg.add("StaticArrays")

# ╔═╡ e8ab064f-e58d-4006-abaa-05ebfc87df88
Pkg.add("OneHotArrays")

# ╔═╡ 317f834a-0512-4f3a-9410-c08cd454e39b
Pkg.add("QuickPOMDPs")

# ╔═╡ 5a39c469-bde9-47f1-aa7f-da2a381a4978
Pkg.add("Parameters")

# ╔═╡ ad255117-a3b8-4b66-b79b-8c5d0946053a
Pkg.add("Plots")

# ╔═╡ 176d21d2-e178-4622-b25c-9de72d675c59
Pkg.add("Distributions")

# ╔═╡ 373272eb-5274-4d77-befe-5ee799c99e1e
Pkg.add("ColorSchemes")

# ╔═╡ 89d5917d-86ee-44d2-8b0b-c84e9f01286d
Pkg.add("Colors")

# ╔═╡ f72e8f9a-7d2e-4d36-ae6f-9f52a72d070e
Pkg.add("Latexify")

# ╔═╡ feacb0c5-595f-465d-b40d-e05b2bb6c516
Pkg.add("PlutoUI")

# ╔═╡ efd79e16-190d-40a6-9987-a16465d1c70d
Pkg.add("FFMPEG")

# ╔═╡ 52146c87-d7ab-4fae-b04e-e677d9235f53
Pkg.add("cuDNN")

# ╔═╡ f9b07909-0df3-4eba-932d-4c19edf22106
Pkg.add("Flux")

# ╔═╡ 999cbb0a-76f1-4ba5-bf64-e34c4a424a3b
Pkg.add("MCTS")

# ╔═╡ fbe10a2b-5217-4700-95ea-5ab666d62a3c
Pkg.add("Reel")

# ╔═╡ 629a2252-4d95-4d58-a004-96d491a26fcc
Pkg.add("D3Trees")

# ╔═╡ 73d38b5c-c823-47ec-b5a0-12e84760cee7
Pkg.add("TabularTDLearning")

# ╔═╡ 00f31771-a287-47b9-8adf-40c7d23bb7ea
using Debugger

# ╔═╡ 3c4e8e72-015c-4ad4-b2de-ed1bb1eacc37
using POMDPModels

# ╔═╡ 594c88f5-5e84-4abf-8218-f905fbf0e922
using StaticArrays

# ╔═╡ e3be07a0-191e-4180-8e8f-02a07dd08352
using OneHotArrays

# ╔═╡ 8477c27b-ea40-4c59-b1ca-da8b641eb884
using POMDPs          # for MDP type

# ╔═╡ ae71c096-311f-4da5-8a6c-3829242af1f9
using POMDPModelTools # for SparseCat distribution

# ╔═╡ d91bcc7c-0941-4d6c-b695-026c33f67329
using POMDPPolicies   # for Policy type

# ╔═╡ 232d7d72-94f8-4dfe-abdf-2b6e712847f7
using QuickPOMDPs     # for QuickMDP

# ╔═╡ e1850dbb-30ea-4e1e-94f7-10582f89fb5d
using Parameters, Random

# ╔═╡ 43a7c406-3d59-4b80-8d34-7b6119e9c936
using Plots; default(fontfamily="Computer Modern", framestyle=:box) # LaTex-style

# ╔═╡ ddd669eb-bdaa-4db3-9781-ed22dc2f0655
using Distributions: Normal

# ╔═╡ aad71f9f-bc67-4258-8a6c-260e63c40670
using Distributions: cdf

# ╔═╡ 1ac38756-c96a-4a92-9d17-3591057ee6b8
using DiscreteValueIteration

# ╔═╡ 081e74ee-8f52-4a9b-8be5-d0a3cbd46988
using ColorSchemes

# ╔═╡ b440c44a-5261-41b9-b27b-65ee43af4ffe
using Colors

# ╔═╡ 891d93cc-50bd-404e-8b8f-543287d2efd9
using Latexify

# ╔═╡ c9811b7f-d076-42e7-9236-950a5f5051c3
using FFMPEG

# ╔═╡ 46311cba-fd3d-455b-a928-1add57fc2fd0
using MCTS

# ╔═╡ 7af3cb40-e49d-42c0-b87d-b898d1f27c1c
using Reel

# ╔═╡ 8d5e27eb-8da3-45e9-8c0d-bcf42fc33959
using D3Trees

# ╔═╡ 77388668-2419-410e-a384-f931fc375a5b
using TabularTDLearning

# ╔═╡ ee2c3be5-2812-47d9-a4b1-36de5f34a4ca
using PyCall

# ╔═╡ 7ce1bec4-f238-407e-aefb-c633ee2fadd5
begin
	using PlutoUI

	md"""
	# Markov Decision Processes
	##### Julia Academy: _Decision Making Under Uncertainty with POMDPs.jl_

	An introduction to MDPs using [`QuickPOMDPs`](https://github.com/JuliaPOMDP/QuickPOMDPs.jl) that's part of the `POMDPs.jl` ecosystem.

	-- Robert Moss (Stanford University) as part of [_Julia Academy_](https://juliaacademy.com/) (Github: [mossr](https://github.com/mossr))
	"""
end

# ╔═╡ 67faae61-5978-49b5-a1fa-5c0399c10312
using POMDPGym

# ╔═╡ 09770092-05c4-418b-b1ae-92b7fad1f6ad
using Flux

# ╔═╡ f217a555-54e2-4b2a-9d67-7e9340147325
using Crux

# ╔═╡ 1f965ca7-8a36-4acf-a5d0-5e5b092ab6af
using Crux: DiscreteNetwork, action_space, state_space, DQN, solve

# ╔═╡ 6e6d983c-7cb3-4f85-ac0c-f1daf8ee3fee
using POMDPSimulators

# ╔═╡ db0265cd-ebe0-4bf2-9e70-c0f978b91ff6
md"""
## Lecture Outline
- Markov Decision Process (MDP) Definition
- Grid World Problem
  - State Space
  - Action Space
  - Transition Function
  - Reward Function
- Solution Methods
    - Offline Algorithms
        - Value Iteration
        - Q-Learning
        - SARSA
    - Online Algorithms
        - Monte Carlo Tree Search (MCTS)
- Simulations
    - Rollout Simulator Visualization
"""

# ╔═╡ faf0ca6e-693d-4217-9e3c-e9e60339d416
md"""
## Markov Decision Process (MDP)

A Markov decision process (MDP) is a 5-tuple consisting of:

$\langle \mathcal{S}, \mathcal{A}, T, R, \gamma \rangle$

Variable | Description | `POMDPs` Interface
:----------- | :-------------- | :------:
$\mathcal{S}$ | State space | `POMDPs.states`
$\mathcal{A}$ | Action space | `POMDPs.actions`
$T$ | Transition function | `POMDPs.transition`
$R$ | Reward function | `POMDPs.reward`
$\gamma \in [0,1]$ | Discount factor | `POMDPs.discount`
"""

# ╔═╡ a84c5d59-ebc6-465e-8d92-87618b5712f0
md"""
- State space $\mathcal{S}$: `POMDPs.states`
- Action space $\mathcal{A}$: `POMDPs.actions`
- Transition function $T$ (sometimes called $P$): `POMDPs.transition`
- Reward function $R$: `POMDPs.reward`
- Discount factor $\gamma \in [0, 1]$: `POMDPs.discount`
"""

# ╔═╡ 8d30248e-b3c3-4f37-8296-392898790283
md"""
State spaces $\mathcal{S}$ and action spaces $\mathcal{A}$ represent all possible states an agent can be in and actions an agent can take. These spaces can either be _discrete_ (i.e., a finite number of possible values) or _continuous_ (i.e., infinite possible values).

In this notebook we only consider **_discrete_** states and actions.

We refer to the _transition function_ and the _reward function_ as "_the model_".
"""

# ╔═╡ 5e9b28a4-50b9-4c44-8d3c-48eb72bda3a5
md"""
## Grid World Problem (MDP)
In the _Grid World_ problem, an _agent_ moves around a grid attempting to collect as much reward as possible, trying to avoid negative rewards.
"""

# ╔═╡ 63b46029-c1c6-43b6-8782-30899b4af98c
pyimport_conda("gym", "gym-all")

# ╔═╡ e2a84ebf-a259-43c1-b512-f6c6b6e02d14
md"""
### Environment Parameters (setup)
First we set some parameters that help us define the Grid World environment (these could be global variables, but we choose to consolidate them to a single `GridWorldParams` structure).

These parameters defines the _size_ of the grid, a _null state_ for convenience, and the probability of transitioning to the chosen cell $p_\text{transition}$.
"""

# ╔═╡ 31ae33aa-5f25-4cd8-8e63-8e77c2233208
md"""
### States

A state $s$ in the Grid World problem is a discrete $(x,y)$ value in a $10\times10$ grid.
"""

# ╔═╡ b83aceeb-4360-43ab-9396-ac57a9416791
struct State <: StaticArrays.FieldVector{2, Int}
	x::Int
	y::Int
end

# ╔═╡ 07846f69-2f7a-4e12-9f4b-6fed8659e9ed
md"""
#### State space
The state space $\mathcal{S}$ for the Grid World problem is the set of all $(x,y)$ values in the $10\times10$ grid, including a null state at $(-1, -1)$.
"""

# ╔═╡ 99acb099-742c-4d13-abd8-c588217e4466
md"""
> **Note**: type `\scrS` then `<TAB>` to generate `𝒮` (example of LaTeX-style unicode characters).
"""

# ╔═╡ 581376af-21eb-4cc8-91af-7b671ebf4e71
md"""
We also define the `==` function so we can directly compare `State` types.
"""

# ╔═╡ c1d07fca-1fbd-4450-96b1-c829d7ad8306
Base.:(==)(s1::State, s2::State) = (s1.x == s2.x) && (s1.y == s2.y)

# ╔═╡ c092511d-c2e7-4b8c-8104-b4b10893cb02
@with_kw struct GridWorldParameters
	size::Tuple{Int,Int} = (7, 7)   # size of the grid
	null_state::State = State(-1, -1) # terminal state outside of the grid
	p_transition::Real = 0.7 # probability of transitioning to the correct next state
	wind_dict::Dict{State, Tuple{Int, Float64}} = Dict(
		State(-1, -1) => (0,0),#needed for Crux?
		State(1,7) => (5,0),      
		State(2,7) => (5,7*pi/4),
		State(3,7) => (10,5*pi/3),
		State(4,7) => (10,3*pi/2),
		State(5,7) => (15,3*pi/2),
		State(6,7) => (15,4*pi/3),
		State(7,7) => (15,4*pi/3),
		State(1,6) => (5,0),
		State(2,6) => (10,pi/4),
		State(3,6) => (10,0),     
		State(4,6) => (10,0),
		State(5,6) => (15,0),
        State(6,6) => (15,7*pi/4),
		State(7,6) => (15,4*pi/3),
		State(1,5) => (5,0),
        State(2,5) => (5,pi/2),   
		State(3,5) => (10,pi/4),
		State(4,5) => (10,0),
        State(5,5) => (15,7*pi/4),
		State(6,5) => (15,3*pi/2),
		State(7,5) => (15,4*pi/3),
        State(1,4) => (5,0),      
		State(2,4) => (5,pi/2),
		State(3,4) => (10,pi/2),  
		State(4,4) => (10,3*pi/4),
        State(5,4) => (15,3*pi/2),
		State(6,4) => (15,3*pi/2),
		State(7,4) => (15,3*pi/2),
        State(1,3) => (5,0),      
		State(2,3) => (5,pi/2),
		State(3,3) => (10,3*pi/4),
		State(4,3) => (5,7*pi/6),
        State(5,3) => (5,5*pi/4), 
		State(6,3) => (15,3*pi/2),
		State(7,3) => (15,3*pi/2),
        State(1,2) => (5,0),      
		State(2,2) => (5,pi/2),
		State(3,2) => (5,pi),
		State(4,2) => (5,pi),
        State(5,2) => (5,pi),     
		State(6,2) => (5,7*pi/4),
		State(7,2) => (15,3*pi/2),
        State(1,1) => (5,0),      
		State(2,1) => (5,pi/2),
		State(3,1) => (5,3*pi/4),
		State(4,1) => (5,3*pi/4),
        State(5,1) => (5,3*pi/4),
		State(6,1) => (5,3*pi/4),
		State(7,1) => (15,3*pi/2)
	)
end	

# ╔═╡ 13dbf845-14a7-4c98-a1db-b3a83c9ce37c
params = GridWorldParameters();

# ╔═╡ 4a14aee4-12f1-4d55-9532-9b88e4c465f8
𝒮 = [[State(x,y) for x=1:params.size[1], y=1:params.size[2]]..., params.null_state]

# ╔═╡ dcfc1975-04e8-4d8e-ab46-d1e0846c071e
md"""
### Actions

The possible actions $s$ are movements in the cardinal directions, using Julia's built-in `@enum` macro.
"""

# ╔═╡ bcc5e8a3-1e3a-40cf-a306-13599a4952ac
@enum Action UP UL LEFT DL DOWN DR RIGHT UR

# ╔═╡ 52b96024-9f52-4f07-926b-2297ed7dd166
# create policy grid showing the best action in each state
function policy_grid(policy::Policy, xmax::Int, ymax::Int)
    arrows = Dict(UP => "↑",
				  UL => "↖",
				  LEFT => "←",
		          DL => "↙",
				  DOWN => "↓",
		          DR => "↘",
                  RIGHT => "→",
				  UR => "↗")

    grid = Array{String}(undef, xmax, ymax)
    for x = 1:xmax, y = 1:xmax
        s = State(x, y)
		a = action(policy, s)
		if a isa AbstractVector
			a = a[1]
		end
		#Vector{
		#println(a)
		#println(typeof(a))
		#println(typeof(RIGHT))
        grid[x,y] = arrows[a]
    end

    return grid
end

# ╔═╡ 90662948-8659-4892-b5b8-53188be05a8f
typeof(UL)

# ╔═╡ d66edb3a-7ccc-4e75-8d42-8d5b1ff5afbb
md"""
#### Action space
The action space $\mathcal{A}$ is made up of all possible actions. Note, `\scrA<TAB>` produces 𝒜.
"""

# ╔═╡ bc541507-61db-4084-9712-1c57d139e17f
𝒜 = [UP, UL, LEFT, DL, DOWN, DR, RIGHT, UR]

# ╔═╡ b2856919-5529-431b-8025-0b7f3f3081b0
md"""
For convenience, we use a dictionary to map actions to their movements applied to states. We overload the `+` operator from `Base` to define how to add two states together, used in the `transition` function below.
"""

# ╔═╡ 1303be2a-d18c-44b0-afb9-06a6b4ce5c08
begin
	const MOVEMENTS = Dict(UP    => State(0,1),
						   DOWN  => State(0,-1),
						   LEFT  => State(-1,0),
						   RIGHT => State(1,0),
						   UL    => State(-1, 1),
						   DL    => State(-1, -1),
						   DR    => State(1, -1),
						   UR    => State(1, 1)
						   );

	Base.:+(s1::State, s2::State) = State(s1.x + s2.x, s1.y + s2.y)
end

# ╔═╡ 125d4f9f-748b-4354-83dc-6131b077e52b
function Velocity(vmin, headAngle, windMag, windAngle)
	x_comp = vmin * cos(headAngle) + windMag * cos(windAngle)
	y_comp = vmin * sin(headAngle) + windMag * sin(windAngle)

	r_angle = atan(y_comp, x_comp)
	r_mag = sqrt(x_comp * x_comp + y_comp * y_comp)

	if (r_angle < 0)
		r_angle += 2 * pi
	end

	return(r_angle, r_mag)
	#Fx = Vmin*jp.cos(HeadAngle)+WindState0*jp.cos(WindState1) 
end

# ╔═╡ 268e2bb2-e6e2-4198-ad83-a93fcfa65b80
md"""
### Transition Function
The dynamics to transition the agent live in the transition function $T(s^\prime \mid s, a)$. The transition function returns a **distribution** over next states $s^\prime$ given the current state $s$ and an action $a$.
"""

# ╔═╡ 148d8e67-33a4-4065-911e-9ee0c33d8822
md"We define a boundry helper function to ensure the agent stays within the grid."

# ╔═╡ 49901c66-db64-48a2-b122-84d5f6b769db
inbounds(s::State) = 1 ≤ s.x ≤ params.size[1] && 1 ≤ s.y ≤ params.size[2]

# ╔═╡ 51796bfc-ee3c-4cab-9d58-359608fd4106
md"""
### Reward Function
The reward functions $R(s)$ and $R(s,a)$ return the rewards for any given `State`. Note, certain problem formulations may use $R(s)$ or $R(s,a)$, or even $R(s,a,s')$ to compute the rewards. The Grid World problem only cares about $R(s)$.
"""

# ╔═╡ f45a4ed7-c613-4e5c-8469-534860e365bc
function SOC_drop_empirical(anglediff)
	c=0.5
	if (anglediff<=pi/4 || anglediff>=7*pi/4)
		return c#0.04
	elseif (anglediff>pi/4 && anglediff<=3*pi/4)  
		return 20*c#2* 0.04
	elseif (anglediff>3*pi/4 && anglediff<=5*pi/4)
		return 80*c#4* 0.04
	else #if anglediff>5*pi/4 and anglediff<7*pi/4: 
		return 20*c#2* 0.04
	end
end

# ╔═╡ f7814a66-23c8-4782-ba06-755397af87db
function R(s, a=missing, s2=missing, useSOC=true)
	#R(s, a=missing, s2=missing, useSOC=true)
	if s == State(3,4)
		return -5
	elseif s == State(5,5)
		return -5
	elseif s == State(7,1)
		return 5
	
	elseif (ismissing(a) || ismissing(s2))
		#print("missing a in call to R()")#this is ok when called from T()
		return 0
	#elseif !ismissing(s2)
	#	#print("s2 has a value!")
	#	(local_wind_mag, local_wind_angle) = params.wind_dict[s]#

		#distance between adjacent cells
		# c = 200
		
		# dx = c * (s2.x - s.x)
		# dy = c * (s2.y - s.y)

		# #used in Velocity
		# intended_dx = MOVEMENTS[a].x
		# intended_dy = MOVEMENTS[a].y
	
		# headAngle = atan(intended_dy, intended_dx)
		# vmin=20

		# (wfa, world_frame_velocity) = Velocity(vmin, headAngle, local_wind_mag, local_wind_angle)

		# #if s == State(2, 3)
		# 	#print(world_frame_velocity)
		# #end

		# distance = sqrt(dx * dx + dy * dy)

		# time_taken = distance / world_frame_velocity
		# return -1 * time_taken
	else
		(local_wind_mag, local_wind_angle) = params.wind_dict[s]
		if useSOC
			dist_mult = sqrt(2)
			Batt_SOH_drop = 0#dummy initialization
			if (MOVEMENTS[a].x == 0 && MOVEMENTS[a].y == 0)
            	ang_diff=0
            	Batt_SOH_drop=0.08
			elseif (MOVEMENTS[a].x == 1 && MOVEMENTS[a].y == 0)
            	ang_diff=local_wind_angle-0
            	Batt_SOH_drop= SOC_drop_empirical(ang_diff)       
			elseif (MOVEMENTS[a].x == 1 && MOVEMENTS[a].y == 1)
            	ang_diff=abs(local_wind_angle-pi/4)
            	Batt_SOH_drop= dist_mult * SOC_drop_empirical(ang_diff)
			elseif (MOVEMENTS[a].x == 0 && MOVEMENTS[a].y == 1)
           		ang_diff=abs(local_wind_angle-2*pi/4)
           		Batt_SOH_drop= SOC_drop_empirical(ang_diff)
			elseif (MOVEMENTS[a].x == -1 && MOVEMENTS[a].y == 1)
           		ang_diff=abs(local_wind_angle-3*pi/4)
           		Batt_SOH_drop= dist_mult * SOC_drop_empirical(ang_diff)
			elseif (MOVEMENTS[a].x == -1 && MOVEMENTS[a].y == 0)
           		ang_diff=abs(local_wind_angle-4*pi/4)
           		Batt_SOH_drop= SOC_drop_empirical(ang_diff)
			elseif (MOVEMENTS[a].x == -1 && MOVEMENTS[a].y == -1)
           		ang_diff=abs(local_wind_angle-5*pi/4)
           		Batt_SOH_drop= dist_mult * SOC_drop_empirical(ang_diff)
			elseif (MOVEMENTS[a].x == 0 && MOVEMENTS[a].y == -1)
           		ang_diff=abs(local_wind_angle-6*pi/4)
           		Batt_SOH_drop= SOC_drop_empirical(ang_diff)
			else # (MOVEMENTS[a].x == 1 && MOVEMENTS[a].y == -1)
           		ang_diff=abs(local_wind_angle-7*pi/4)
           		Batt_SOH_drop= dist_mult * SOC_drop_empirical(ang_diff)
			end
			return -Batt_SOH_drop
		else
			#print("s2 has no value! Proceeding based on intended action.")
			#print("useSOC is false!")
			
			intended_dx = MOVEMENTS[a].x
			intended_dy = MOVEMENTS[a].y
	
			headAngle = atan(intended_dy, intended_dx)
			vmin=20

			(wfa, world_frame_velocity) = Velocity(vmin, headAngle, local_wind_mag, local_wind_angle)

			intended_distance = sqrt(intended_dx * intended_dx + intended_dy * intended_dy)

			time_taken = intended_distance / world_frame_velocity
			if time_taken < 0
				print("time taken < 0!")
			end
			return -1 * time_taken
		end
	end
end

# ╔═╡ 27e554ff-9861-4a41-ad65-9d5ae7727e45
function T(s::State, a::Action, debug=missing)
	#if s in [State(4,3), State(4,6), State(9,3), State(8,8)]
	if R(s) != 0#don't include a in this case
		return Deterministic(params.null_state)
	end

	Nₐ = length(𝒜)
	next_states = Vector{State}(undef, Nₐ + 1)
	probabilities = zeros(Nₐ + 1)
	p_transition = params.p_transition
	(local_wind_mag, local_wind_angle) = params.wind_dict[s]
	
	
	intended_dx = MOVEMENTS[a].x
	intended_dy = MOVEMENTS[a].y
	
	headAngle = atan(intended_dy, intended_dx)
	vmin=20

	world_frame_velocity = Velocity(vmin, headAngle, local_wind_mag, local_wind_angle)
	if !ismissing(debug)
		print(world_frame_velocity)
	end
	(wfv_angle, wfv_mag) = world_frame_velocity
	#direction and speed of movement after adding the nominal wind at that point
	octnum = div((wfv_angle + pi / 8), (pi / 4))
	ctr = octnum * pi / 4

	if !ismissing(debug)
		print(octnum)
		print("\n")
		print(ctr)
		print("\n")
	end

	mvt_gaussian = Normal(wfv_angle, pi/16)

	ao = cdf(mvt_gaussian, ctr - 3 * pi / 8)
    ab = cdf(mvt_gaussian, ctr - pi / 8)
    bc = cdf(mvt_gaussian, ctr + pi / 8)
    co = cdf(mvt_gaussian, ctr + 3 * pi / 8)

	atemp = ab - ao
    btemp = bc - ab
    ctemp = co - bc

	psum = atemp + btemp + ctemp

	ccwn_p = atemp / psum
	intended_p = btemp / psum
	cwn_p = ctemp / psum

	if !ismissing(debug)
		print(ccwn_p, intended_p, cwn_p)
	end

	neighbors = [UL, UR]#dummy initialization
	for (i, a′) in enumerate(𝒜)
		if a′ == a
			neighbors = (a == UP) ? [UL, UR] : (a == UR) ? [UP, RIGHT] : [𝒜[i-1], 𝒜[i+1]]
		end
	end
	(neighbor_ccw, neighbor_cw) = neighbors
	
	for (i, a′) in enumerate(𝒜) 	
		prob = (a′ == a) ? intended_p : (a′ == neighbor_ccw) ? ccwn_p : (a′ == neighbor_cw) ? cwn_p : 0
		
		destination = s + MOVEMENTS[a′]
		next_states[i+1] = destination

		if inbounds(destination)
			probabilities[i+1] += prob
		end
	end
	
	# handle out-of-bounds transitions
	next_states[1] = s
	probabilities[1] = 1 - sum(probabilities)

	if (probabilities[1] < 0)
		if (probabilities[1] < -0.01)#arbitrary threshold
			print("normalizing significant negative probability")
		end
		probabilities[1] = 0
	end

	return SparseCat(next_states, probabilities)
end

# ╔═╡ 3712fb82-4aa4-41bf-a7a4-b61dfbf0c67d
T(State(2,2), RIGHT)

# ╔═╡ 54d7926d-f8d0-4e95-9b29-5b3ce330ea04
params.wind_dict[State(2,3)]

# ╔═╡ af9e2e9b-8d9c-4487-8c67-4e7d3ec4e304
R(State(2,3), UP, State(3,4))

# ╔═╡ e5286fa6-1a48-4020-ab03-c24a175c8c04
md"""
### Discount Factor
For an infinite horizon problem, we set the discount factor $\gamma \in [0,1]$ to a value where $\gamma < 1$ to discount future rewards. We bind $\gamma$ to a `PlutoUI` slider so we can adjust the value in real-time.
"""

# ╔═╡ 87a6c45e-6f3e-428e-8301-3b0c4166a84b
@bind γ Slider(0:0.05:1, default=0.95, show_value=true)

# ╔═╡ fd5b8960-933a-4ca0-9a7e-5003821ccfe3
md"""
### Termination
When the agent is in the `null_state` (which we've arbitrarily defined), then it is in a terminal state. Note for this problem, that termination cannot be _"when you're in a reward state"_, but has to be a separate `null_state` that we transition to _after_ we taken an action in a reward state (thus, _after_ we collect the reward).
"""

# ╔═╡ 6970821b-2b87-4e66-b737-512e83627998
termination(s::State) = s == params.null_state

# ╔═╡ 7c2c2733-eb28-4d85-9074-99e64074e414
md"""
### MDP Formulation (`QuickPOMDPs.jl`)
We can use the convinient package `QuickPOMDPs` to setup the MDP problem formulation for the Grid World problem. We set the _initial state distribution_ to be the entire state space $\mathcal{S}$, which will be sampled uniformly. A separate notebook is provided that creates the MDP in the "traditional" `POMDPs` manner, but we recommend `QuickPOMDPs` to get started.

We define the `GridWorld` abstract `MDP` type so we can reference it in other methods.
"""

# ╔═╡ 49b140ad-641f-436c-9492-cf3efbadd8d2
abstract type GridWorld <: MDP{State, Action} end

# ╔═╡ d9755f26-3f30-48ba-91d7-266c0204237d
# helper functions to get all the values from a policy
begin
	function one_based_policy!(policy)
		# change the default action in the policy (all zeros) to all ones (if needed)
		if all(iszero, policy.policy)
			policy.policy[:] = ones(eltype(policy.policy), length(policy.policy))
		end
	end

    function get_rewards(mdp::QuickMDP{GridWorld}, policy::Policy)
        null_state = params.null_state
        valid_states = setdiff(states(mdp), [null_state])
        U = map(s->reward(mdp, s), valid_states)
    end

    function values(mdp::QuickMDP{GridWorld}, policy::Policy)
        null_state = params.null_state
        valid_states = setdiff(states(mdp), [null_state])
        U = map(s->value(policy, s), valid_states)
    end

    function values(mdp::QuickMDP{GridWorld}, planner::MCTSPlanner)
        null_state = params.null_state
        valid_states = setdiff(states(mdp), [null_state])
        U = []
        for s in valid_states
            u = 0
            try
                u = value(planner, s)
            catch
                # state not in tree
            end
            push!(U, u)
        end
        return U
    end

    function values(mdp::QuickMDP{GridWorld}, policy::ValuePolicy)
        maxU = mapslices(maximum, policy.value_table, dims=2)
        return maxU[1:end-1] # remove null_state
    end

    struct NothingPolicy <: Policy end
    
    # Use this to get a stationary grid of rewards
    function values(mdp::QuickMDP{GridWorld}, policy::Union{NothingPolicy, FunctionPolicy})
        null_state = params.null_state
        valid_states = setdiff(states(mdp), [null_state])
        rewards = map(s->reward(mdp, s), valid_states)
    end
end

# ╔═╡ a3f76a77-bb6d-4a6b-8e5a-170dcc867c07
md"""
## Solutions (Offline)
Depending on the type of problem (discrete/continuous states or actions, model-free vs. model-based), we can pick an MDP solver that meets our needs. For a list of MDP (and POMDP) solvers based on online/offline solutions and continuous/discrete spaces, see the [README](https://github.com/JuliaPOMDP/POMDPs.jl#mdp-solvers) of POMDPs.jl.

Solution methods typically follow the defined `POMDPs.jl` interface syntax:
```julia
solver = FancyAlgorithmSolver() # inputs are the parameters of said algorithm
policy = solve(solver, mdp)     # solves the MDP and returns a policy
```
"""

# ╔═╡ 9f5dc78e-8183-4a03-9282-1aebf1af218c
md"""
### Value Iteration

*Value iteration* is an algorithm to solve discrete MDPs that uses dynamic programming and the Bellman equation to compute the optimal *value* (or *utility*) $U^*$ iteratively.$^2$

$$U^*(s) = \max_a\Biggl(\underbrace{R(s,a)}_{\substack{\text{immediate}\\\text{reward}}} + \overbrace{\gamma \sum_{s^\prime} T(s^\prime \mid s,a) U^*(s^\prime)}^{\text{discounted future reward}}\Biggr) \quad \text{for all states } s$$

The optimal policy $\pi^*$ can be extracted using the value function.

$$\pi^*(s) = \mathop{\rm arg\,max}_a\left(R(s,a) + \gamma \sum_{s^\prime} T(s^\prime \mid s, a) U^*(s^\prime)\right)$$

But, of course, we don't have to implement these algorithms ourselves, we can use `POMDPs.jl` 🙃!
"""

# ╔═╡ 142f0646-541e-453b-a3b1-4b8fadf709cc
# ╠═╡ disabled = true
#=╠═╡
using DiscreteValueIteration
  ╠═╡ =#

# ╔═╡ c67f7fc6-7af8-4e4f-a341-133c70f879bc
md"Value iteration is *model-based* because it relies on the transition model $T$ and reward model $R$ (also called _transition function_ and _reward function_)."

# ╔═╡ 48c966cb-6b79-42a6-8ff0-2fe3261f3981
solver = ValueIterationSolver(max_iterations=30, verbose=true);

# ╔═╡ c6af3de1-1d91-4d5a-95a6-4baf9aca3c08
# ╠═╡ disabled = true
#=╠═╡
@requirements_info ValueIterationSolver() mdp()
  ╠═╡ =#

# ╔═╡ 12501ad4-b42d-4fc4-b54b-30f4b929c0ab
md"""
#### Policy
We set the discount factor to the variable $\gamma$ which is bound to a slider, and solve the MDP to obtain a policy $\pi$ mapping states $s$ to actions $a$.

$$\pi(s) = a$$
"""

# ╔═╡ 90b507bd-8cab-4c30-816e-a4b264e903a6
md"### Example: _Transition Probability and State-Value_
What does the transition probability distribution look like from some current state $s_r$? Also, what is the _value_ of a particular state (shown in the color gradient)?"

# ╔═╡ 73182581-fdf4-4252-b64e-34f39e1f96da
function plot_transition_probability(distr)
	if distr isa Deterministic
		vals = [distr.val]
		probs = [1]
	else
		vals = distr.vals
		probs = distr.probs
	end
	xtick_states = [(v.x,v.y) for v in vals]
	@info xtick_states
	@info probs
	cmap_probs = ColorScheme([colorant"#B3BCDB", colorant"#4063D8"])
	bar(probs,
		xformatter = x->1 <= x <= length(xtick_states) ? xtick_states[Int(x)] : "",
		label=false,
		aspect_ratio=5,
		group=xtick_states,
		color=map(v->get(cmap_probs, v), probs))
	title!("Transition Probability\nDistribution")
	xlabel!("next state 𝑠′")
	ylabel!("probability")
	ylims!(0, 1.1)
	xlims!(0, 6)
	yticks!(0:0.1:1)
end

# ╔═╡ 786b27eb-129f-4538-beca-7e8b69fd40e4
md"""
 $(x,y)$ = $(@bind state_x NumberField(1:10, default=1)) | $(@bind state_y NumberField(1:10, default=3))
"""

# ╔═╡ 9cb6e19b-25f4-44b5-8155-d55ad3ba617c
sᵣ = State(state_x, state_y)

# ╔═╡ da9926ae-4e49-4ff3-abc2-d8249bddb0f2
md"And can look at the distribution over next states $s^\prime$ via $T(s^\prime \mid s, a)$."

# ╔═╡ b942fd56-13c3-4729-a701-63f103b13638
md"""
### Example: _Using the Policy_
Given some current state $s$, we can pull out an action $a$ using the policy $\pi$:

$$\pi(s) = a$$

"""

# ╔═╡ 4de6845e-a555-4147-86e8-d623e399c22a
md"We can query the policy $\pi$ for an action using the `action(π, s)` function."

# ╔═╡ 887f90ce-98eb-4262-894b-e14a0a53fa50
md"We can look at the value $U(s)$ at an individual state given the policy."

# ╔═╡ a4e4d65f-a734-404d-8478-029b0017651c
md"""
And also look at the state-action value, or $Q$-value, over all possible actions, where

$$Q(s,a) = \underbrace{R(s,a)}_{\substack{\text{immediate}\\\text{reward}}} + \overbrace{\gamma \sum_{s^\prime} T(s^\prime \mid s,a) U(s^\prime)}^{\text{discounted future reward}}.$$

We use the `value(π, s)` function for $U(s)$ and `value(π, s, a)` for $Q(s,a)$, where

$$U(s) = \max_a Q(s,a)$$
"""

# ╔═╡ 73cde70f-17f9-4ccd-ae4e-0cf050c2915e
Q(π, s, a) = value(π, s, a) # Q-value (i.e., state-action value)

# ╔═╡ cd4d33c8-bc24-4327-a65e-ed2d46af766b
md"## Visualization"

# ╔═╡ d3b0aeb2-11c9-4d4e-aa53-bb831ccd74a2
md"""
### Value Iteration Policy

The arrows in each cell (i.e. state) show the policy, and the color represents the discounted utility $U(s)$ (where green is positive utility and red is negative utility).
"""

# ╔═╡ b9100f1b-4903-4edc-a371-2f4b0eb20298
T(State(5,1), RIGHT, true)

# ╔═╡ d63ff91c-42c9-410f-96f3-27277a6c4b35
𝒜

# ╔═╡ 1adac9e9-9711-4ed7-b34b-979d272e6267
params.wind_dict[State(6,2)]

# ╔═╡ a8817d6e-2302-4f39-8b93-66d550ca09ef
@bind vi_iterations Slider(0:30, default=0, show_value=true)

# ╔═╡ 5024e6c5-39e2-4bd6-acca-05267cf8639e
vi_solver = ValueIterationSolver(max_iterations=vi_iterations);

# ╔═╡ 3590b4b0-5a05-4052-aa58-f48d3912ce77
@bind γ_vi Slider(0:0.05:1, default=0.95, show_value=true)

# ╔═╡ 4d698cad-a570-4608-b6dd-20de5d7dbe33
vi_mdp = QuickMDP(GridWorld,
    states       = 𝒮,
    actions      = 𝒜,
    transition   = T,
    reward       = R,
    discount     = γ_vi, # custom discount for visualization of Value Iteration policy
    initialstate = 𝒮,
    isterminal   = termination);

# ╔═╡ 1540a649-b238-498e-a8fb-5a29461194b5
vi_policy = solve(vi_solver, vi_mdp);

# ╔═╡ 1ae17bb4-35db-48fa-8b32-b8d669025160
action(vi_policy, State(5,1))

# ╔═╡ b5834c6a-687b-4b74-869c-6f01fa066fdb
value(vi_policy, State(5,1))

# ╔═╡ 6d024b5b-faa3-4075-babd-c6b260cef55e
one_based_policy!(vi_policy); # handles the case when iterations = 0

# ╔═╡ dd5e9a13-4297-4717-a150-e1908faea2ca
md"""
Here's an example where we can save the rendering as an SVG file using the `Plots.jl` package.
"""

# ╔═╡ b4dd0437-b945-4b4e-a504-1ac0fca54a75
md"""
### Animated GIF
"""

# ╔═╡ 38af3571-9b0a-4b19-b33a-573101b597a0
md"Create value iteration GIF? $(@bind create_gif CheckBox())"

# ╔═╡ a2b7e745-8b15-42c6-89ca-e97aef1c9a0f
md"""
## Reinforcement Learning Solvers
"""

# ╔═╡ a94529cf-1ab3-4b28-887a-04be9d103869
html"""
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="369.699pt" height="185.742pt" viewBox="0 0 369.699 185.742" version="1.1">
<defs>
<g>
<symbol overflow="visible" id="rl-glyph0-0">
<path style="stroke:none;" d=""/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-1">
<path style="stroke:none;" d="M 12.984375 -5.40625 L 12.375 -5.40625 C 11.859375 -2.1875 11.53125 -0.875 8.109375 -0.875 L 5.453125 -0.875 C 4.515625 -0.875 4.609375 -0.875 4.609375 -1.53125 L 4.609375 -6.734375 L 6.28125 -6.734375 C 8.203125 -6.734375 8.28125 -6.21875 8.28125 -4.40625 L 9.046875 -4.40625 L 9.046875 -9.9375 L 8.28125 -9.9375 C 8.28125 -8.09375 8.203125 -7.609375 6.28125 -7.609375 L 4.609375 -7.609375 L 4.609375 -12.25 C 4.609375 -12.90625 4.515625 -12.921875 5.453125 -12.921875 L 8.03125 -12.921875 C 11.078125 -12.921875 11.46875 -11.953125 11.796875 -9.0625 L 12.578125 -9.0625 L 12 -13.8125 L 0.515625 -13.8125 L 0.515625 -12.921875 L 1.140625 -12.921875 C 2.671875 -12.921875 2.5625 -12.828125 2.5625 -12.109375 L 2.5625 -1.671875 C 2.5625 -0.953125 2.671875 -0.875 1.140625 -0.875 L 0.515625 -0.875 L 0.515625 0 L 12.25 0 L 13.125 -5.40625 Z M 12.984375 -5.40625 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-2">
<path style="stroke:none;" d="M 10.78125 -0.125 L 10.78125 -0.875 C 9.625 -0.875 9.25 -0.734375 9.21875 -1.328125 L 9.21875 -5.140625 C 9.21875 -6.859375 9.1875 -7.5625 8.5625 -8.28125 C 8.28125 -8.625 7.546875 -9.0625 6.390625 -9.0625 C 4.9375 -9.0625 3.859375 -8.0625 3.3125 -6.828125 L 3.5625 -6.828125 L 3.5625 -9.078125 L 0.5 -8.84375 L 0.5 -7.96875 C 2.03125 -7.96875 2.046875 -7.953125 2.046875 -6.96875 L 2.046875 -1.640625 C 2.046875 -0.734375 1.96875 -0.875 0.5 -0.875 L 0.5 0.015625 L 2.890625 -0.0625 L 5.234375 0.015625 L 5.234375 -0.875 C 3.78125 -0.875 3.6875 -0.734375 3.6875 -1.640625 L 3.6875 -5.296875 C 3.6875 -7.375 4.984375 -8.359375 6.25 -8.359375 C 7.515625 -8.359375 7.59375 -7.40625 7.59375 -6.28125 L 7.59375 -1.640625 C 7.59375 -0.734375 7.515625 -0.875 6.03125 -0.875 L 6.03125 0.015625 L 8.421875 -0.0625 L 10.78125 0.015625 Z M 10.78125 -0.125 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-3">
<path style="stroke:none;" d="M 10.234375 -8.09375 L 10.234375 -8.859375 C 9.65625 -8.8125 9.078125 -8.78125 8.625 -8.78125 L 6.75 -8.84375 L 6.75 -7.96875 C 7.625 -7.953125 7.703125 -7.609375 7.703125 -7.234375 C 7.703125 -7.046875 7.671875 -6.96875 7.59375 -6.75 L 5.5625 -1.671875 L 5.8125 -1.671875 L 3.578125 -7.234375 C 3.46875 -7.484375 3.421875 -7.484375 3.421875 -7.484375 L 3.46875 -7.5625 C 3.46875 -8.09375 4.125 -7.96875 4.609375 -7.96875 L 4.609375 -8.84375 L 2.3125 -8.78125 C 1.765625 -8.78125 0.96875 -8.8125 0.234375 -8.859375 L 0.234375 -7.96875 C 1.640625 -7.96875 1.578125 -7.96875 1.828125 -7.34375 L 4.703125 -0.28125 C 4.828125 0 5 0.21875 5.265625 0.21875 C 5.515625 0.21875 5.71875 -0.078125 5.796875 -0.28125 L 8.40625 -6.75 C 8.59375 -7.21875 8.8125 -7.953125 10.234375 -7.96875 Z M 10.234375 -8.09375 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-4">
<path style="stroke:none;" d="M 5.046875 -0.125 L 5.046875 -0.875 C 3.609375 -0.875 3.640625 -0.84375 3.640625 -1.609375 L 3.640625 -9.078125 L 0.59375 -8.84375 L 0.59375 -7.96875 C 2.03125 -7.96875 2.078125 -7.96875 2.078125 -7 L 2.078125 -1.640625 C 2.078125 -0.734375 1.984375 -0.875 0.515625 -0.875 L 0.515625 0.015625 L 2.84375 -0.0625 C 3.546875 -0.0625 4.25 -0.015625 5.046875 0.015625 Z M 3.9375 -12.15625 C 3.9375 -12.6875 3.359375 -13.34375 2.765625 -13.34375 C 2.09375 -13.34375 1.546875 -12.65625 1.546875 -12.15625 C 1.546875 -11.609375 2.15625 -10.984375 2.75 -10.984375 C 3.421875 -10.984375 3.9375 -11.65625 3.9375 -12.15625 Z M 3.9375 -12.15625 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-5">
<path style="stroke:none;" d="M 7.375 -7.703125 C 7.375 -8.34375 6.640625 -9.0625 5.78125 -9.0625 C 4.328125 -9.0625 3.46875 -7.59375 3.1875 -6.734375 L 3.453125 -6.734375 L 3.453125 -9.078125 L 0.421875 -8.84375 L 0.421875 -7.96875 C 1.953125 -7.96875 1.96875 -7.953125 1.96875 -6.96875 L 1.96875 -1.640625 C 1.96875 -0.734375 1.890625 -0.875 0.421875 -0.875 L 0.421875 0.015625 L 2.828125 -0.0625 C 3.625 -0.0625 4.5625 -0.0625 5.484375 0.015625 L 5.484375 -0.875 L 4.9375 -0.875 C 3.46875 -0.875 3.546875 -0.953125 3.546875 -1.671875 L 3.546875 -4.734375 C 3.546875 -6.71875 4.265625 -8.359375 5.78125 -8.359375 C 5.921875 -8.359375 5.859375 -8.40625 5.890625 -8.390625 L 6 -8.609375 C 5.9375 -8.59375 5.40625 -8.203125 5.40625 -7.6875 C 5.40625 -7.125 5.953125 -6.71875 6.390625 -6.71875 C 6.75 -6.71875 7.375 -7.078125 7.375 -7.703125 Z M 7.375 -7.703125 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-6">
<path style="stroke:none;" d="M 9.5 -4.375 C 9.5 -6.9375 7.390625 -9.1875 4.984375 -9.1875 C 2.484375 -9.1875 0.421875 -6.875 0.421875 -4.375 C 0.421875 -1.8125 2.625 0.21875 4.953125 0.21875 C 7.375 0.21875 9.5 -1.859375 9.5 -4.375 Z M 7.59375 -4.546875 C 7.59375 -3.828125 7.625 -2.84375 7.1875 -1.96875 L 7.15625 -1.875 C 6.71875 -0.96875 5.96875 -0.53125 4.984375 -0.53125 C 4.125 -0.53125 3.328125 -0.921875 2.78125 -1.828125 C 2.296875 -2.703125 2.328125 -3.828125 2.328125 -4.546875 C 2.328125 -5.3125 2.296875 -6.3125 2.765625 -7.1875 C 3.3125 -8.109375 4.15625 -8.484375 4.953125 -8.484375 C 5.84375 -8.484375 6.59375 -8.09375 7.109375 -7.234375 C 7.625 -6.375 7.59375 -5.296875 7.59375 -4.546875 Z M 7.59375 -4.546875 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-7">
<path style="stroke:none;" d="M 16.3125 -0.125 L 16.3125 -0.875 C 15.15625 -0.875 14.78125 -0.734375 14.765625 -1.328125 L 14.765625 -5.140625 C 14.765625 -6.859375 14.71875 -7.5625 14.109375 -8.28125 C 13.828125 -8.625 13.09375 -9.0625 11.9375 -9.0625 C 10.265625 -9.0625 9.25 -7.734375 8.90625 -6.96875 L 9.15625 -6.96875 C 8.890625 -8.703125 7.296875 -9.0625 6.390625 -9.0625 C 4.9375 -9.0625 3.859375 -8.0625 3.3125 -6.828125 L 3.5625 -6.828125 L 3.5625 -9.078125 L 0.5 -8.84375 L 0.5 -7.96875 C 2.03125 -7.96875 2.046875 -7.953125 2.046875 -6.96875 L 2.046875 -1.640625 C 2.046875 -0.734375 1.96875 -0.875 0.5 -0.875 L 0.5 0.015625 L 2.890625 -0.0625 L 5.234375 0.015625 L 5.234375 -0.875 C 3.78125 -0.875 3.6875 -0.734375 3.6875 -1.640625 L 3.6875 -5.296875 C 3.6875 -7.375 4.984375 -8.359375 6.25 -8.359375 C 7.515625 -8.359375 7.59375 -7.40625 7.59375 -6.28125 L 7.59375 -1.640625 C 7.59375 -0.734375 7.515625 -0.875 6.03125 -0.875 L 6.03125 0.015625 L 8.421875 -0.0625 L 10.78125 0.015625 L 10.78125 -0.875 C 9.328125 -0.875 9.21875 -0.734375 9.21875 -1.640625 L 9.21875 -5.296875 C 9.21875 -7.375 10.515625 -8.359375 11.796875 -8.359375 C 13.046875 -8.359375 13.125 -7.40625 13.125 -6.28125 L 13.125 -1.640625 C 13.125 -0.734375 13.046875 -0.875 11.578125 -0.875 L 11.578125 0.015625 L 13.96875 -0.0625 L 16.3125 0.015625 Z M 16.3125 -0.125 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-8">
<path style="stroke:none;" d="M 8.390625 -2.484375 C 8.390625 -2.6875 8.109375 -2.875 8.015625 -2.875 C 7.828125 -2.875 7.65625 -2.609375 7.609375 -2.453125 C 6.90625 -0.390625 5.265625 -0.53125 5.0625 -0.53125 C 4.0625 -0.53125 3.34375 -1.09375 2.890625 -1.828125 C 2.296875 -2.78125 2.328125 -4 2.328125 -4.609375 L 7.765625 -4.609375 C 8.203125 -4.609375 8.390625 -4.71875 8.390625 -5.140625 C 8.390625 -7.109375 7.1875 -9.1875 4.703125 -9.1875 C 2.390625 -9.1875 0.421875 -7 0.421875 -4.5 C 0.421875 -1.828125 2.65625 0.21875 4.9375 0.21875 C 7.375 0.21875 8.390625 -2.109375 8.390625 -2.484375 Z M 6.953125 -5.28125 L 2.375 -5.28125 C 2.46875 -8.109375 4.03125 -8.484375 4.703125 -8.484375 C 6.75 -8.484375 6.8125 -5.921875 6.8125 -5.28125 Z M 6.953125 -5.28125 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-9">
<path style="stroke:none;" d="M 6.734375 -2.59375 L 6.734375 -3.859375 L 5.96875 -3.859375 L 5.96875 -2.625 C 5.96875 -1.15625 5.515625 -0.53125 4.78125 -0.53125 C 3.453125 -0.53125 3.5625 -2.21875 3.5625 -2.546875 L 3.5625 -7.96875 L 6.421875 -7.96875 L 6.421875 -8.84375 L 3.5625 -8.84375 L 3.5625 -12.515625 L 2.8125 -12.515625 C 2.78125 -10.734375 2.328125 -8.75 0.234375 -8.671875 L 0.234375 -7.96875 L 1.9375 -7.96875 L 1.9375 -2.59375 C 1.9375 -0.140625 3.921875 0.21875 4.640625 0.21875 C 6.0625 0.21875 6.734375 -1.3125 6.734375 -2.59375 Z M 6.734375 -2.59375 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-10">
<path style="stroke:none;" d="M 14.40625 -0.125 L 14.40625 -0.875 L 13.921875 -0.875 C 12.734375 -0.875 12.578125 -0.875 12.34375 -1.53125 L 8.046875 -13.984375 C 7.953125 -14.25 7.796875 -14.515625 7.46875 -14.515625 C 7.15625 -14.515625 6.953125 -14.265625 6.859375 -13.984375 L 2.734375 -2.078125 C 2.375 -1.0625 1.71875 -0.890625 0.5 -0.875 L 0.5 0.015625 L 2.671875 -0.0625 L 5.078125 0.015625 L 5.078125 -0.875 C 3.96875 -0.875 3.578125 -1.234375 3.578125 -1.75 C 3.578125 -1.8125 3.5625 -1.9375 3.625 -2.015625 L 4.5 -4.546875 L 9.25 -4.546875 L 10.265625 -1.609375 C 10.28125 -1.53125 10.3125 -1.421875 10.3125 -1.328125 C 10.3125 -0.734375 9.34375 -0.875 8.671875 -0.875 L 8.671875 0.015625 C 9.515625 -0.0625 10.921875 -0.0625 11.671875 -0.0625 L 14.40625 0.015625 Z M 9.125 -5.421875 L 4.828125 -5.421875 L 7 -11.75 L 6.734375 -11.75 L 8.921875 -5.421875 Z M 9.125 -5.421875 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-11">
<path style="stroke:none;" d="M 9.78125 -8.171875 C 9.78125 -8.5 9.421875 -9.28125 8.640625 -9.28125 C 8.25 -9.28125 7.265625 -9.125 6.515625 -8.390625 C 5.78125 -8.96875 4.859375 -9.0625 4.421875 -9.0625 C 2.5625 -9.0625 1.0625 -7.546875 1.0625 -6.015625 C 1.0625 -5.140625 1.53125 -4.296875 1.9375 -3.96875 C 1.765625 -3.765625 1.375 -3.015625 1.375 -2.3125 C 1.375 -1.6875 1.671875 -0.859375 2.078125 -0.59375 C 1.1875 -0.34375 0.421875 0.65625 0.421875 1.453125 C 0.421875 2.890625 2.53125 4.109375 4.953125 4.109375 C 7.3125 4.109375 9.5 2.96875 9.5 1.421875 C 9.5 0.71875 9.1875 -0.390625 8.171875 -0.953125 C 7.109375 -1.515625 5.875 -1.546875 4.65625 -1.546875 C 4.15625 -1.546875 3.3125 -1.546875 3.171875 -1.578125 C 2.53125 -1.65625 2.234375 -2.125 2.234375 -2.765625 C 2.234375 -2.84375 2.1875 -3.234375 2.46875 -3.53125 C 3.125 -3.0625 4.046875 -2.96875 4.421875 -2.96875 C 6.28125 -2.96875 7.765625 -4.46875 7.765625 -6 C 7.765625 -6.734375 7.40625 -7.5625 7.015625 -7.921875 C 7.625 -8.53125 8.265625 -8.59375 8.625 -8.59375 L 8.703125 -8.625 C 8.703125 -8.625 8.765625 -8.59375 8.828125 -8.5625 L 8.828125 -8.828125 C 8.609375 -8.75 8.359375 -8.390625 8.359375 -8.140625 C 8.359375 -7.8125 8.765625 -7.453125 9.078125 -7.453125 C 9.28125 -7.453125 9.78125 -7.703125 9.78125 -8.171875 Z M 6.015625 -6.015625 C 6.015625 -5.484375 6.03125 -4.9375 5.734375 -4.4375 C 5.578125 -4.203125 5.21875 -3.6875 4.421875 -3.6875 C 2.6875 -3.6875 2.8125 -5.53125 2.8125 -6 C 2.8125 -6.53125 2.78125 -7.09375 3.09375 -7.59375 C 3.25 -7.828125 3.625 -8.34375 4.421875 -8.34375 C 6.15625 -8.34375 6.015625 -6.46875 6.015625 -6.015625 Z M 8.203125 1.453125 C 8.203125 2.53125 6.9375 3.390625 4.984375 3.390625 C 2.96875 3.390625 1.71875 2.515625 1.71875 1.453125 C 1.71875 0.53125 2.34375 -0.078125 3.234375 -0.140625 L 4.40625 -0.140625 C 6.109375 -0.140625 8.203125 -0.265625 8.203125 1.453125 Z M 8.203125 1.453125 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-12">
<path style="stroke:none;" d="M 14.484375 -6.875 C 14.484375 -10.9375 11.359375 -14.296875 7.734375 -14.296875 C 4.15625 -14.296875 0.96875 -10.984375 0.96875 -6.875 C 0.96875 -2.78125 4.1875 0.4375 7.734375 0.4375 C 11.359375 0.4375 14.484375 -2.84375 14.484375 -6.875 Z M 12.171875 -7.15625 C 12.171875 -1.875 9.578125 -0.34375 7.75 -0.34375 C 5.84375 -0.34375 3.28125 -1.953125 3.28125 -7.15625 C 3.28125 -12.3125 6.078125 -13.546875 7.734375 -13.546875 C 9.46875 -13.546875 12.171875 -12.25 12.171875 -7.15625 Z M 12.171875 -7.15625 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-13">
<path style="stroke:none;" d="M 10.5 -4.421875 C 10.5 -6.953125 8.421875 -9.0625 6.15625 -9.0625 C 4.609375 -9.0625 3.640625 -8.09375 3.328125 -7.734375 L 3.546875 -7.625 L 3.546875 -14.109375 L 0.421875 -13.859375 L 0.421875 -12.984375 C 1.953125 -12.984375 1.96875 -12.96875 1.96875 -12 L 1.96875 0 L 2.671875 0 L 3.328125 -1.109375 C 3.53125 -0.8125 4.46875 0.21875 5.9375 0.21875 C 8.3125 0.21875 10.5 -1.859375 10.5 -4.421875 Z M 8.59375 -4.4375 C 8.59375 -3.703125 8.59375 -2.609375 8.015625 -1.71875 C 7.59375 -1.09375 6.9375 -0.484375 5.859375 -0.484375 C 4.953125 -0.484375 4.328125 -0.921875 3.84375 -1.65625 C 3.5625 -2.078125 3.609375 -2.03125 3.609375 -2.390625 L 3.609375 -6.5 C 3.609375 -6.875 3.5625 -6.8125 3.78125 -7.125 C 4.5625 -8.25 5.578125 -8.359375 6.0625 -8.359375 C 6.953125 -8.359375 7.5625 -7.890625 8.046875 -7.125 C 8.5625 -6.3125 8.59375 -5.265625 8.59375 -4.4375 Z M 8.59375 -4.4375 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-14">
<path style="stroke:none;" d="M 7.296875 -2.671875 C 7.296875 -3.71875 6.65625 -4.421875 6.421875 -4.65625 C 5.75 -5.296875 4.90625 -5.5 4.0625 -5.65625 C 2.953125 -5.875 1.734375 -6 1.734375 -7.15625 C 1.734375 -7.84375 2.125 -8.546875 3.84375 -8.546875 C 6.03125 -8.546875 6 -6.875 6.03125 -6.25 C 6.0625 -6.078125 6.5 -6 6.5 -6 L 6.421875 -5.953125 C 6.671875 -5.953125 6.796875 -6.171875 6.796875 -6.546875 L 6.796875 -8.5625 C 6.796875 -8.90625 6.671875 -9.1875 6.453125 -9.1875 C 6.359375 -9.1875 6.21875 -9.140625 5.953125 -8.90625 C 5.890625 -8.828125 5.703125 -8.640625 5.703125 -8.671875 C 5.046875 -9.140625 4.140625 -9.1875 3.84375 -9.1875 C 1.421875 -9.1875 0.515625 -7.703125 0.515625 -6.59375 C 0.515625 -5.890625 0.875 -5.265625 1.421875 -4.828125 C 2.046875 -4.296875 2.703125 -4.140625 4.140625 -3.859375 C 4.578125 -3.78125 6.078125 -3.578125 6.078125 -2.15625 C 6.078125 -1.140625 5.515625 -0.484375 3.96875 -0.484375 C 2.296875 -0.484375 1.6875 -1.46875 1.3125 -3.171875 C 1.25 -3.421875 1.109375 -3.640625 0.921875 -3.640625 C 0.65625 -3.640625 0.515625 -3.359375 0.515625 -3.015625 L 0.515625 -0.375 C 0.515625 -0.046875 0.65625 0.21875 0.875 0.21875 C 0.96875 0.21875 1.078125 0.15625 1.453125 -0.21875 C 1.5 -0.265625 1.5 -0.296875 1.765625 -0.578125 C 2.546875 0.15625 3.546875 0.21875 3.96875 0.21875 C 6.25 0.21875 7.296875 -1.234375 7.296875 -2.671875 Z M 7.296875 -2.671875 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-15">
<path style="stroke:none;" d="M 9.734375 -1.890625 L 9.734375 -3.140625 L 8.984375 -3.140625 L 8.984375 -1.890625 C 8.984375 -0.734375 8.625 -0.75 8.40625 -0.75 C 7.75 -0.75 7.796875 -1.515625 7.796875 -1.609375 L 7.796875 -5.59375 C 7.796875 -6.4375 7.75 -7.3125 7.03125 -8.046875 C 6.25 -8.828125 5.171875 -9.1875 4.21875 -9.1875 C 2.59375 -9.1875 1.078125 -8.109375 1.078125 -6.796875 C 1.078125 -6.203125 1.609375 -5.734375 2.125 -5.734375 C 2.6875 -5.734375 3.171875 -6.25 3.171875 -6.765625 C 3.171875 -7.015625 2.953125 -7.8125 2.296875 -7.828125 C 2.65625 -8.3125 3.546875 -8.484375 4.1875 -8.484375 C 5.15625 -8.484375 6.15625 -7.828125 6.15625 -6.0625 L 6.15625 -5.453125 C 5.28125 -5.40625 3.890625 -5.34375 2.625 -4.734375 C 1.140625 -4.0625 0.5 -2.890625 0.5 -2.015625 C 0.5 -0.390625 2.5625 0.21875 3.828125 0.21875 C 5.140625 0.21875 6.171875 -0.703125 6.546875 -1.640625 L 6.296875 -1.640625 C 6.375 -0.84375 7.046875 0.125 7.984375 0.125 C 8.40625 0.125 9.734375 -0.28125 9.734375 -1.890625 Z M 6.15625 -2.90625 C 6.15625 -1.015625 4.859375 -0.484375 3.96875 -0.484375 C 2.984375 -0.484375 2.296875 -1.03125 2.296875 -2.03125 C 2.296875 -3.125 3.015625 -4.65625 6.15625 -4.765625 Z M 6.15625 -2.90625 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-16">
<path style="stroke:none;" d="M 6.71875 4.65625 C 6.71875 4.609375 6.671875 4.46875 6.328125 4.125 C 3.84375 1.609375 3.25 -2.046875 3.25 -5.09375 C 3.25 -8.5625 3.96875 -11.953125 6.421875 -14.4375 C 6.671875 -14.6875 6.71875 -14.796875 6.71875 -14.859375 C 6.71875 -15 6.515625 -15.203125 6.390625 -15.203125 C 6.203125 -15.203125 4.265625 -13.703125 3.09375 -11.171875 C 2.078125 -8.984375 1.828125 -6.765625 1.828125 -5.09375 C 1.828125 -3.546875 2.046875 -1.140625 3.140625 1.109375 C 4.34375 3.5625 6.203125 4.984375 6.390625 4.984375 C 6.515625 4.984375 6.71875 4.796875 6.71875 4.65625 Z M 6.71875 4.65625 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-17">
<path style="stroke:none;" d="M 5.875 -5.09375 C 5.875 -6.65625 5.65625 -9.0625 4.5625 -11.3125 C 3.359375 -13.765625 1.53125 -15.203125 1.328125 -15.203125 C 1.21875 -15.203125 1 -14.984375 1 -14.859375 C 1 -14.796875 1.03125 -14.6875 1.421875 -14.328125 C 3.359375 -12.34375 4.46875 -9.265625 4.46875 -5.09375 C 4.46875 -1.6875 3.765625 1.71875 1.296875 4.21875 C 1.03125 4.46875 1 4.609375 1 4.65625 C 1 4.78125 1.21875 4.984375 1.328125 4.984375 C 1.53125 4.984375 3.453125 3.5 4.625 0.96875 C 5.640625 -1.21875 5.875 -3.421875 5.875 -5.09375 Z M 5.875 -5.09375 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph0-18">
<path style="stroke:none;" d="M 8.390625 -2.484375 C 8.390625 -2.6875 8.0625 -2.828125 8.015625 -2.828125 C 7.828125 -2.828125 7.65625 -2.609375 7.609375 -2.484375 C 7.03125 -0.640625 5.875 -0.53125 5.140625 -0.53125 C 4.078125 -0.53125 2.453125 -1.25 2.453125 -4.46875 C 2.453125 -7.703125 3.96875 -8.421875 5.015625 -8.421875 C 5.203125 -8.421875 6.359375 -8.453125 6.828125 -7.921875 C 6.328125 -7.890625 6.078125 -7.15625 6.078125 -6.890625 C 6.078125 -6.375 6.578125 -5.859375 7.125 -5.859375 C 7.65625 -5.859375 8.171875 -6.3125 8.171875 -6.90625 C 8.171875 -8.265625 6.53125 -9.1875 5 -9.1875 C 2.515625 -9.1875 0.53125 -6.890625 0.53125 -4.421875 C 0.53125 -1.875 2.65625 0.21875 4.953125 0.21875 C 7.625 0.21875 8.390625 -2.296875 8.390625 -2.484375 Z M 8.390625 -2.484375 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph1-0">
<path style="stroke:none;" d=""/>
</symbol>
<symbol overflow="visible" id="rl-glyph1-1">
<path style="stroke:none;" d="M 9.34375 -5.4375 C 9.34375 -7.515625 7.953125 -8.8125 6.15625 -8.8125 C 3.484375 -8.8125 0.8125 -5.96875 0.8125 -3.140625 C 0.8125 -1.171875 2.15625 0.21875 4 0.21875 C 6.65625 0.21875 9.34375 -2.53125 9.34375 -5.4375 Z M 4.03125 -0.21875 C 3.171875 -0.21875 2.296875 -0.84375 2.296875 -2.390625 C 2.296875 -3.359375 2.8125 -5.515625 3.453125 -6.53125 C 4.4375 -8.0625 5.578125 -8.359375 6.140625 -8.359375 C 7.296875 -8.359375 7.890625 -7.40625 7.890625 -6.21875 C 7.890625 -5.4375 7.484375 -3.34375 6.734375 -2.046875 C 6.03125 -0.890625 4.9375 -0.21875 4.03125 -0.21875 Z M 4.03125 -0.21875 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph1-2">
<path style="stroke:none;" d="M 7.4375 -7.53125 C 7.078125 -8.265625 6.5 -8.8125 5.59375 -8.8125 C 3.265625 -8.8125 0.796875 -5.875 0.796875 -2.96875 C 0.796875 -1.09375 1.890625 0.21875 3.453125 0.21875 C 3.84375 0.21875 4.84375 0.140625 6.03125 -1.28125 C 6.203125 -0.4375 6.890625 0.21875 7.84375 0.21875 C 8.546875 0.21875 9 -0.234375 9.328125 -0.875 C 9.65625 -1.59375 9.921875 -2.8125 9.921875 -2.84375 C 9.921875 -3.046875 9.734375 -3.046875 9.6875 -3.046875 C 9.484375 -3.046875 9.46875 -2.96875 9.40625 -2.6875 C 9.0625 -1.390625 8.703125 -0.21875 7.890625 -0.21875 C 7.34375 -0.21875 7.296875 -0.734375 7.296875 -1.140625 C 7.296875 -1.578125 7.328125 -1.734375 7.546875 -2.609375 C 7.765625 -3.453125 7.8125 -3.640625 7.984375 -4.40625 L 8.703125 -7.1875 C 8.84375 -7.75 8.84375 -7.796875 8.84375 -7.875 C 8.84375 -8.203125 8.609375 -8.40625 8.265625 -8.40625 C 7.796875 -8.40625 7.484375 -7.96875 7.4375 -7.53125 Z M 6.140625 -2.375 C 6.03125 -2.015625 6.03125 -1.96875 5.734375 -1.640625 C 4.859375 -0.53125 4.046875 -0.21875 3.484375 -0.21875 C 2.484375 -0.21875 2.21875 -1.3125 2.21875 -2.09375 C 2.21875 -3.09375 2.84375 -5.53125 3.3125 -6.453125 C 3.921875 -7.625 4.828125 -8.359375 5.625 -8.359375 C 6.90625 -8.359375 7.1875 -6.734375 7.1875 -6.609375 C 7.1875 -6.5 7.15625 -6.375 7.125 -6.28125 Z M 6.140625 -2.375 "/>
</symbol>
<symbol overflow="visible" id="rl-glyph2-0">
<path style="stroke:none;" d=""/>
</symbol>
<symbol overflow="visible" id="rl-glyph2-1">
<path style="stroke:none;" d="M 3.4375 -5.515625 L 4.859375 -5.515625 C 5.125 -5.515625 5.296875 -5.515625 5.296875 -5.8125 C 5.296875 -6.015625 5.125 -6.015625 4.890625 -6.015625 L 3.5625 -6.015625 L 4.078125 -8.078125 C 4.09375 -8.15625 4.109375 -8.21875 4.109375 -8.28125 C 4.109375 -8.53125 3.921875 -8.71875 3.640625 -8.71875 C 3.296875 -8.71875 3.078125 -8.484375 2.984375 -8.125 C 2.890625 -7.765625 3.0625 -8.4375 2.453125 -6.015625 L 1.03125 -6.015625 C 0.765625 -6.015625 0.59375 -6.015625 0.59375 -5.703125 C 0.59375 -5.515625 0.75 -5.515625 1 -5.515625 L 2.328125 -5.515625 L 1.5 -2.21875 C 1.421875 -1.875 1.296875 -1.375 1.296875 -1.1875 C 1.296875 -0.359375 2 0.140625 2.796875 0.140625 C 4.34375 0.140625 5.21875 -1.8125 5.21875 -2 C 5.21875 -2.171875 5.03125 -2.171875 5 -2.171875 C 4.828125 -2.171875 4.8125 -2.15625 4.703125 -1.90625 C 4.3125 -1.03125 3.59375 -0.25 2.828125 -0.25 C 2.546875 -0.25 2.34375 -0.4375 2.34375 -0.9375 C 2.34375 -1.078125 2.40625 -1.375 2.421875 -1.5 Z M 3.4375 -5.515625 "/>
</symbol>
</g>
<clipPath id="rl-clip1">
  <path d="M 193 58 L 369.699219 58 L 369.699219 127 L 193 127 Z M 193 58 "/>
</clipPath>
</defs>
<g id="rl-surface1">
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 81.053969 28.347562 L -81.055406 28.347562 C -83.254625 28.347562 -85.039781 26.562406 -85.039781 24.363187 L -85.039781 -24.363375 C -85.039781 -26.562594 -83.254625 -28.34775 -81.055406 -28.34775 L 81.053969 -28.34775 C 83.257094 -28.34775 85.04225 -26.562594 85.04225 -24.363375 L 85.04225 24.363187 C 85.04225 26.562406 83.257094 28.347562 81.053969 28.347562 Z M 81.053969 28.347562 " transform="matrix(1,0,0,-1,85.239,92.871)"/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-1" x="28.88" y="99.536"/>
  <use xlink:href="#rl-glyph0-2" x="42.449116" y="99.536"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-3" x="52.969664" y="99.536"/>
  <use xlink:href="#rl-glyph0-4" x="63.490211" y="99.536"/>
  <use xlink:href="#rl-glyph0-5" x="69.029439" y="99.536"/>
  <use xlink:href="#rl-glyph0-6" x="76.840149" y="99.536"/>
  <use xlink:href="#rl-glyph0-2" x="86.802789" y="99.536"/>
  <use xlink:href="#rl-glyph0-7" x="97.881245" y="99.536"/>
  <use xlink:href="#rl-glyph0-8" x="114.479003" y="99.536"/>
  <use xlink:href="#rl-glyph0-2" x="123.325827" y="99.536"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-9" x="133.846375" y="99.536"/>
</g>
<g clip-path="url(#rl-clip1)" clip-rule="nonzero">
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 280.280531 28.347562 L 118.171156 28.347562 C 115.968031 28.347562 114.182875 26.562406 114.182875 24.363187 L 114.182875 -24.363375 C 114.182875 -26.562594 115.968031 -28.34775 118.171156 -28.34775 L 280.280531 -28.34775 C 282.47975 -28.34775 284.264906 -26.562594 284.264906 -24.363375 L 284.264906 24.363187 C 284.264906 26.562406 282.47975 28.347562 280.280531 28.347562 Z M 280.280531 28.347562 " transform="matrix(1,0,0,-1,85.239,92.871)"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-10" x="258.448" y="97.952"/>
  <use xlink:href="#rl-glyph0-11" x="273.39196" y="97.952"/>
  <use xlink:href="#rl-glyph0-8" x="283.3546" y="97.952"/>
  <use xlink:href="#rl-glyph0-2" x="292.201424" y="97.952"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-9" x="302.721972" y="97.952"/>
</g>
<path style="fill:none;stroke-width:1.59404;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 28.714125 28.746 C 67.815687 67.843656 131.409438 67.843656 165.690688 33.562406 " transform="matrix(1,0,0,-1,85.239,92.871)"/>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 255.75 64.125 C 254.589844 62.429688 253.070313 59.308594 252.402344 56.765625 L 248.386719 60.78125 C 250.929688 61.449219 254.050781 62.964844 255.75 64.125 "/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-12" x="113.051" y="21.585"/>
  <use xlink:href="#rl-glyph0-13" x="128.552868" y="21.585"/>
  <use xlink:href="#rl-glyph0-14" x="139.631324" y="21.585"/>
  <use xlink:href="#rl-glyph0-8" x="147.481884" y="21.585"/>
  <use xlink:href="#rl-glyph0-5" x="156.328708" y="21.585"/>
  <use xlink:href="#rl-glyph0-3" x="164.139418" y="21.585"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-15" x="173.54415" y="21.585"/>
  <use xlink:href="#rl-glyph0-9" x="183.50679" y="21.585"/>
  <use xlink:href="#rl-glyph0-4" x="191.257724" y="21.585"/>
  <use xlink:href="#rl-glyph0-6" x="196.796952" y="21.585"/>
  <use xlink:href="#rl-glyph0-2" x="206.759592" y="21.585"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-16" x="224.473166" y="21.585"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph1-1" x="232.223" y="21.585"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph2-1" x="241.881" y="24.575"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-17" x="248.897" y="21.585"/>
</g>
<path style="fill:none;stroke-width:1.59404;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 170.511 -28.746188 C 131.409438 -67.843844 67.815687 -67.843844 33.534437 -33.562594 " transform="matrix(1,0,0,-1,85.239,92.871)"/>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 113.953125 121.617188 C 115.113281 123.3125 116.632813 126.433594 117.300781 128.976563 L 121.316406 124.960938 C 118.773438 124.292969 115.648438 122.777344 113.953125 121.617188 "/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-10" x="136.225" y="174.12"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-18" x="150.611052" y="174.12"/>
  <use xlink:href="#rl-glyph0-9" x="159.457876" y="174.12"/>
  <use xlink:href="#rl-glyph0-4" x="167.20881" y="174.12"/>
  <use xlink:href="#rl-glyph0-6" x="172.748038" y="174.12"/>
  <use xlink:href="#rl-glyph0-2" x="182.710678" y="174.12"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-16" x="200.424252" y="174.12"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph1-2" x="208.175" y="174.12"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph2-1" x="218.707" y="177.108"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#rl-glyph0-17" x="225.723" y="174.12"/>
</g>
</g>
</svg>
"""

# ╔═╡ 2d58ccfd-9b20-459a-a636-a47496df1b18
md"""
### Temporal Difference Learning
Temporal difference (TD) learning algorithms are model-free reinforcement learning algorithms that learn the value function by sampling from the environment.

The `TabularTDLearning.jl` package includes $Q$-learning, $\rm S{\small ARSA}$, and $\rm S{\small ARSA(\lambda)}$.
"""

# ╔═╡ f0725051-8770-47d5-b8a7-65b1ab0955dd
md"""
### Q-Learning
The $Q$-learning algorithm$^3$ is model-free meaning it does not rely on the transition model $T$ or the reward model $R$, but uses samples of reward $r$ and the next state $s^\prime$.

$$Q(s,a) \leftarrow Q(s,a) + \alpha\overbrace{\biggl(\underbrace{r + \gamma \max_{a^\prime} Q(s^\prime, a^\prime)}_{\rm TD\ target} - Q(s,a)\biggr)}^{\rm temporal\ difference}
$$

In more detail, the $Q(s,a)$ equation means:
$$
\begin{align}
\rm new\ value \leftarrow \rm old\ value &+\ \\ \rm learning\ rate \ \cdot &\biggl(\rm reward\ + discount \cdot \bigl(future\ value\ estimate\bigr) - \rm old\ value \biggr)
\end{align}$$
"""

# ╔═╡ 10994f20-831d-4c63-ba4d-fe7e43347d5d
@bind γ_q Slider(0:0.05:1, default=0.95, show_value=true)

# ╔═╡ 9d1994d2-7ea9-4828-98fc-27bf5d17bab9
q_mdp = QuickMDP(GridWorld,
    states       = 𝒮,
    actions      = 𝒜,
    transition   = T,
    reward       = R,
    discount     = γ_q, # custom discount for visualization of Q-learning policy
    initialstate = 𝒮,
    isterminal   = termination);

# ╔═╡ acbaca80-cafb-49c3-adea-4fd507c2c142
md"""
#### Q-learning Solver
"""

# ╔═╡ 2db772d9-16a1-4bdb-9205-611a1921831f
md"""
#### Q-learning Policy
"""

# ╔═╡ 9cf0f694-d4a3-48fd-9cb0-1c8ac0361d5c
@bind n_episodes_q Slider(1:500, default=500)

# ╔═╡ 61e6ad96-ff2a-4dd9-9698-48c33bd43f26
q_learning_solver = QLearningSolver(n_episodes=n_episodes_q,
                                    learning_rate=0.8,
                                    exploration_policy=EpsGreedyPolicy(q_mdp, 0.5),
	                                verbose=false);

# ╔═╡ ee7c1fe5-2991-4b2a-981b-1c72106d5855
q_learning_policy = solve(q_learning_solver, q_mdp);

# ╔═╡ bf23cf92-103f-4181-b9e6-97efe0249d0a
md"""
### SARSA
The $\rm S{\small ARSA}$ algorithm$^4$ is a modification of $Q$-learning that uses $(s, a, r, s^\prime, a^\prime)$. It uses the actual next action $a^\prime$ to update the $Q$-values **instead** of maximizing over all actions.

$$Q(s,a) \leftarrow Q(s,a) + \alpha\overbrace{\biggl(\underbrace{r + \gamma Q(s^\prime, a^\prime)}_{\rm TD\ target} - Q(s,a)\biggr)}^{\rm temporal\ difference}
$$

In more detail, the $Q(s,a)$ equation means:
$$
\begin{align}
\rm new\ value \leftarrow \rm old\ value &+\ \\ \rm learning\ rate \ \cdot &\biggl(\rm reward\ + discount \cdot \bigl(next\ value\bigr) - \rm old\ value \biggr)
\end{align}$$
"""

# ╔═╡ 1c1c765e-3a36-42f2-b1cb-8683b265ecad
@bind γ_sarsa Slider(0:0.05:1, default=0.95, show_value=true)

# ╔═╡ 3bcf0923-8ac2-4f82-97ca-d0996658a046
sarsa_mdp = QuickMDP(GridWorld,
    states       = 𝒮,
    actions      = 𝒜,
    transition   = T,
    reward       = R,
    discount     = γ_sarsa, # custom discount for visualization of SARSA policy
    initialstate = 𝒮,
    isterminal   = termination);

# ╔═╡ e8620cb9-21de-4e5d-805a-0571eeceef7d
md"""
#### SARSA Solver
"""

# ╔═╡ c0929ea6-4b20-4e34-bec3-f0fc5935e406
md"""
#### SARSA Policy
"""

# ╔═╡ 5bfbceb4-7006-47c0-a965-13500caef00d
@bind n_episodes_sarsa Slider(0:10:1000, default=500)

# ╔═╡ f73f735c-6e8a-4ad4-b404-9772ce557eb1
sarsa_solver = SARSASolver(n_episodes=n_episodes_sarsa,
                           learning_rate=0.8,
                           exploration_policy=EpsGreedyPolicy(sarsa_mdp, 0.5),
	                       verbose=false);

# ╔═╡ 133eaaec-7113-4ec6-bac0-555f6efa1cb3
sarsa_policy = solve(sarsa_solver, sarsa_mdp);

# ╔═╡ cabde5e8-a783-4c93-af0f-d9e0eee264ce
md"""
### Deep Q-Learning
"""

# ╔═╡ b0d01d02-8d4e-41b4-9e0b-9c453f76aed2
function Q_network()
	layer1 = Dense(2, 64, relu)
	layer2 = Dense(64, 64, relu)
	layer3 = Dense(64, length(𝒜))
	return DiscreteNetwork(Chain(layer1, layer2, layer3), 𝒜)
end

# ╔═╡ d313469b-8ff8-437b-b980-3643147ffedc
action_space(Q_network())

# ╔═╡ ebeb07a9-3ce5-4bc6-a5a3-6b9cc5db13a5
#=╠═╡
sso = POMDPs.convert_s(AbstractArray, initialstate(mdp), mdp)
  ╠═╡ =#

# ╔═╡ 0d469af2-ee02-45f6-a0f9-fcafbf57d6b8
#=╠═╡
type(css)
  ╠═╡ =#

# ╔═╡ 0e1876b6-be76-4c36-879f-0874cb294d86
# ╠═╡ disabled = true
#=╠═╡
function zero(T::Type{A1}) where {A1<:typeof(State(0,0))}
	return State(0,0)
end
  ╠═╡ =#

# ╔═╡ a6df6e0a-2e8f-4912-a7b8-e22595bcf867
#=╠═╡
css = state_space(sso)
  ╠═╡ =#

# ╔═╡ 4bc5c35c-6d54-4ae8-82d6-cfec28cb437a
#=╠═╡
dss = DiscreteSpace(sso)
  ╠═╡ =#

# ╔═╡ a844f1ad-73c0-4423-b0f8-c1005d7ce932
#=╠═╡
solver_dqn = DQN(π=Q_network(), S=dss, N=30000)
  ╠═╡ =#

# ╔═╡ 8678ffd0-9b3e-4d9a-bdc2-51488db4fe99
#=╠═╡
solver_dqn.S
  ╠═╡ =#

# ╔═╡ ffba0c02-b49b-44ec-8e26-fbe0aba98fbe
State(0, 0)

# ╔═╡ 6798fa98-b54e-4025-ba55-c456ffe6c038
#=╠═╡
solver_dqn.S.vals
  ╠═╡ =#

# ╔═╡ 65cc321c-85e4-47a7-9ba8-9c943dcf4426
#=╠═╡
State(4, 5) in solver_dqn.S.vals
  ╠═╡ =#

# ╔═╡ 33eae184-86bd-4b0f-9547-7f5ba327a32e
#=╠═╡
Flux.onehot(State(1,1), solver_dqn.S.vals)
  ╠═╡ =#

# ╔═╡ 2009c8c9-bae0-40e3-a1be-7ec4e9a09d4d
# ╠═╡ disabled = true
#=╠═╡
POMDPs.convert_s(T::Type{<:AbstractArray}, s::State, m::QuickPOMDPs.QuickMDP) = convert(T, vcat(s))
  ╠═╡ =#

# ╔═╡ 714a3736-cb91-4aae-844c-e458e885f7b8
# ╠═╡ disabled = true
#=╠═╡
function convert_s(T::Type{A1}, s::State, problem::MDP) where {A1<:AbstractArray}
	return s
end
  ╠═╡ =#

# ╔═╡ f5b900e6-dccb-4b4a-93ea-a80a717d65f9
#=╠═╡
POMDPs.convert_s(AbstractArray, State(1,1), mdp)
  ╠═╡ =#

# ╔═╡ d83d0ab3-5f33-43f6-9700-1d63eee1f36b
#=╠═╡
sampler = Crux.Sampler(
	mdp, 
	solver_dqn.agent, 
	s=srand,
	S=solver_dqn.S, 
	#svec = Flux.onehot(State(1,1), solver_dqn.S.vals),
	svec=Crux.tovec(srand, dss),
	max_steps=solver_dqn.max_steps, 
	required_columns=solver_dqn.required_columns
)
  ╠═╡ =#

# ╔═╡ 6efdc038-e234-4748-8efc-ef3372916cdf
#=╠═╡
initial_observation(sampler.mdp, sampler.s)
  ╠═╡ =#

# ╔═╡ 73c49153-3eb1-4ac7-8cb2-be72bd3b4a78
#=╠═╡
solver_dqn.N
  ╠═╡ =#

# ╔═╡ 0112328f-8cd9-472c-89d6-89a27c1b5740
#=╠═╡
solver_dqn.ΔN
  ╠═╡ =#

# ╔═╡ 581e850c-4f89-4fb7-b674-c7be1b290de3
#=╠═╡
solver_dqn.i
  ╠═╡ =#

# ╔═╡ c371c236-c5f8-46e0-86b3-a16592b65c69
#=╠═╡
initial_observation(sampler.mdp, sampler.s)
  ╠═╡ =#

# ╔═╡ bd90f02a-99f3-4596-9063-b762cc6d4288
#=╠═╡
OneHotArrays.onehot(State(-1, -1), solver_dqn.S.vals)
  ╠═╡ =#

# ╔═╡ 793485d1-06ab-47ac-a30f-e969dbe60ff8
typeof(State(-1, -1))

# ╔═╡ 6a2a16f7-ef76-4125-a452-01cfaec5212c
#=╠═╡
typeof(initial_observation(sampler.mdp, sampler.s))
  ╠═╡ =#

# ╔═╡ 56784563-c8bc-4b42-b0ae-d14c0bc6ef9f
sgg = POMDPModels.SimpleGridWorld()

# ╔═╡ a5587b98-311b-48f9-b921-fd9e677f693f
state_space(sgg)

# ╔═╡ b7324c2f-7dd3-45a5-b5a0-a0f160d5b6fe
solver_dqn_sgg = DQN(π=Q_network(), S=state_space(sgg), N=30000)

# ╔═╡ 2806c392-2f99-4751-8cd2-f8493a0a858a
# ╠═╡ disabled = true
#=╠═╡
policy_sgg = solve(solver_dqn_sgg, sgg)
  ╠═╡ =#

# ╔═╡ a8711617-3d6f-4465-bc72-ddf315bf187f


# ╔═╡ 9840980c-fff7-492f-9e31-8ca0a355edb4
gmdp = GridWorldMDP()

# ╔═╡ 8a986284-5758-47a1-af46-caf1bf4c8b00
A_gwmdp() = DiscreteNetwork(Chain(Dense(Crux.dim(state_space(gmdp))..., 64, relu), Dense(64, 64, relu), Dense(64, length(actions(gmdp)))), actions(gmdp))

# ╔═╡ 01268c82-d479-47b7-9ae0-220cda895776
# ╠═╡ disabled = true
#=╠═╡
S_gwmdp_dqn = DQN(π=A_gwmdp(), S=state_space(gmdp), N=10000, interaction_storeage=[])
  ╠═╡ =#

# ╔═╡ 677640fa-c0fd-49a3-b4d9-73a6c37b94fd
DiscreteSpace(5)

# ╔═╡ 116a84d2-4a8e-40e8-91fe-8dc65dfb12e7
#=╠═╡
Flux.onehot(initial_observation(sampler.mdp, sampler.s), solver_dqn.S.vals)
  ╠═╡ =#

# ╔═╡ a9fff980-9e26-4389-bdb5-2a0dbebb2cd7
#=╠═╡
tovec(initial_observation(sampler.mdp, sampler.s), solver_dqn.S)
  ╠═╡ =#

# ╔═╡ 83a089f2-4364-4f5e-959f-b7e1e6644749
#=╠═╡
State(5, 2) ∈ solver_dqn.S.vals
  ╠═╡ =#

# ╔═╡ de7632bc-bfda-4972-8407-221f30943b72
#=╠═╡
State(-1, -1) ∈ solver_dqn.S.vals
  ╠═╡ =#

# ╔═╡ 88ca10db-fb4e-4d35-ba82-6f70014d0a11
#=╠═╡
solver_dqn.S.vals
  ╠═╡ =#

# ╔═╡ 1572f01a-5414-4b51-980b-9e248bb37186
#=╠═╡
policy_dqn = solve(solver_dqn, mdp)
  ╠═╡ =#

# ╔═╡ 279d7550-ac70-4391-85ff-859aff6260d5
π = Q_network()

# ╔═╡ b1c00123-0c78-43a8-8aad-0876d5bd0553
π_explore =  Crux.ϵGreedyPolicy(Crux.LinearDecaySchedule(1., 0.1, floor(Int, 30000/2)), π.outputs)

# ╔═╡ 31e06e7a-8d8d-431f-8879-23edd4f47390
agent = PolicyParams(π=π, π_explore=π_explore, π⁻=deepcopy(π))

# ╔═╡ d26fd72c-b76d-48d7-820c-0aaf489f145b
log=nothing

# ╔═╡ bd9c7106-bec7-4ac0-8004-c57a59c9123d
c_opt = TrainingParams(loss=Crux.td_loss(), name=string("critic_"), epochs=4)

# ╔═╡ 9e5dddc2-5152-4d87-ada5-d9724ca8e1ba
target_fn = Crux.DQN_target

# ╔═╡ 3d2fcda5-5a12-4a3a-ade5-ef010161a197
# ╠═╡ disabled = true
#=╠═╡
zero(type(css))
  ╠═╡ =#

# ╔═╡ 9eee0130-13dd-42e4-ab63-80cd93f7b49b
#=╠═╡
dim(css)
  ╠═╡ =#

# ╔═╡ e8cc0f99-f846-4612-b6ba-00510d1e19ec
agent.space

# ╔═╡ c879f1fd-8c81-41b5-9704-1b52dd23fd82
# ╠═╡ disabled = true
#=╠═╡
Crux.mdp_data(css, agent.space, 1000, Symbol[], ArrayType=Array, R=Float32, D=Bool, W=Float32)
  ╠═╡ =#

# ╔═╡ b378c854-a628-4048-8148-ccd5df02835a
# ╠═╡ disabled = true
#=╠═╡
Array(fill(zero(type(css)), dim(css)..., 1000))
  ╠═╡ =#

# ╔═╡ 8bc6fabc-35c1-4de1-9fe8-23305fe4f723
import Base.zero

# ╔═╡ a496ec2c-c833-4e28-8f2c-d03ab3bbf72e
Array(fill(zero(type(agent.space)), dim(agent.space)..., 1000))

# ╔═╡ 93470482-a648-4189-995c-df9b85d96e8c
# ╠═╡ disabled = true
#=╠═╡
test_exb = Crux.ExperienceBuffer(css, agent.space, 1000, Symbol[])
  ╠═╡ =#

# ╔═╡ f2bea74c-9222-456c-bfa7-8ce8e8e7fb69
# ╠═╡ disabled = true
#=╠═╡
solver_dqn = OffPolicySolver(agent=agent, log=log, N=30000, ΔN=4, c_opt=c_opt, target_fn=target_fn, S=css)
  ╠═╡ =#

# ╔═╡ 3ae03c36-877c-4be6-9ed3-37a5b7bac7f6
discrete_mdp = GridWorldMDP()

# ╔═╡ 5bc59e80-8892-4397-8952-0f11fc49441b
S_dm = state_space(discrete_mdp)

# ╔═╡ fecb5e93-7a12-425c-86f8-48d144040a5e
A_dm() = DiscreteNetwork(Chain(Dense(2, 32, relu), Dense(32, 4)), actions(discrete_mdp))

# ╔═╡ e1df43c7-1f3d-42b4-909c-a1c2b05381e3
𝒜

# ╔═╡ d3dc8b0b-2cda-4a61-b7e3-fd201c85d319
# ╠═╡ disabled = true
#=╠═╡
dqn_dm = DQN(π=A_dm(), S=S_dm, N=30000)#NOT OUR MDP!!!
  ╠═╡ =#

# ╔═╡ 942da32d-58f0-4057-88d8-b9077cc350e1
typeof(S_dm)

# ╔═╡ eab76a21-9f55-4a1e-b01f-fce9d441c1eb
# ╠═╡ disabled = true
#=╠═╡
zero(Tuple{Int64})
  ╠═╡ =#

# ╔═╡ 44817047-1ed9-40bd-83e8-e8a2f72963a3
# ╠═╡ disabled = true
#=╠═╡
pi_dm = solve(dqn_dm, discrete_mdp)
  ╠═╡ =#

# ╔═╡ ed0577b6-e270-4f8c-87b1-417f52d3e8d3
value(vi_policy, State(6, 7))

# ╔═╡ 7621029b-0a9a-46ed-9da9-199a2b19ccd0
typeof(RIGHT)

# ╔═╡ f687e004-aab2-4af5-b975-8a335c508c60
# ╠═╡ disabled = true
#=╠═╡
with_terminal() do
	for (s,a,r) in stepthrough(mdp, pi_mdp, "s,a,r", max_steps=100)
		@info "In state ($(s.x), $(s.y)), taking action $a, receiving reward $r"
	end
end		
  ╠═╡ =#

# ╔═╡ 9224816f-b347-4aef-8d70-44a3800b636e


# ╔═╡ f85ee7b1-13df-42a3-a5f7-cc310552010a


# ╔═╡ d96ae1e8-0638-441c-8c1f-1fd39be6611d
# ╠═╡ disabled = true
#=╠═╡
for dqn_mdp.i in range(dqn_mdp.i, stop=dqn_mdp.i + dqn_mdp.N - dqn_mdp.ΔN)
	info = Dict()
	steps!(s_solve, dqn_mdp.buffer, Nsteps=dqn_mdp.ΔN, explore=true, i=dqn_mdp.i, store=dqn_mdp.interaction_storage, cb=(D)->dqn_mdp.post_sample_callback(D, 𝒮=dqn_mdp, info=info))
	dqn_mdp.pre_train_callback(dqn_mdp, info=info)

	#training_info = Crux.value_training(dqn_mdp, D, γ_2)
	infos = []
	for epoch in dqn_mdp.c_opt.epochs
		rand!(D, dqn_mdp.buffer, dqn_mdp.extra_buffers..., fracs=dqn_mdp.buffer_fractions, i=dqn_mdp.i)

		info = Dict()

		dqn_mdp.post_batch_callback(D, 𝒮=dqn_mdp, info=info)
		y = dqn_mdp.target_fn(dqn_mdp.agent.π⁻, dqn_mdp.𝒫, D, γ_2, i=dqn_mdp.i)
		isprioritized(dqn_mdp.buffer) && update_priorities!(dqn_mdp.buffer, D.incices, cpu(dqn_mdp.priority_fn(dqn_mdp.agent.π, dqn_mdp.𝒫, D, γ_2)))
		for (Θs, p_opt) in dqn_mdp.param_optimizers
			train!(Θs, (;kwargs...) -> p_opt.loss(dqn_mdp.agent.π, dqn_mdp.𝒫, D, kwargs...), p_opt, info-info)
		end
		if ((epoch-1) % dqn_mdp.c_opt.update_every) == 0
			#Crux.train!(critic(dqn_mdp.agent.π), (;kwargs...) -> dqn_mdp.c_opt.loss(dqn_mdp.agent.π, dqn_mdp.𝒫, D, γ_2; kwargs...), dqn_mdp.c_opt, info=info)
			l, back = Flux.pullback(() -> dqn_mdp.c_opt.loss(dqn_mdp.agent.π, dqn_mdp.𝒫, D, γ_2; info=info), Flux.params(critic(dqn_mdp.agent.π)))
		end
		
	end
end
  ╠═╡ =#

# ╔═╡ 6d8e4629-5122-4d19-a4ec-a4a7cf8ba8cc
# ╠═╡ disabled = true
#=╠═╡
dqn_mdp.c_opt.loss(dqn_mdp.agent.π, dqn_mdp.𝒫, D, γ_2; info=info)
  ╠═╡ =#

# ╔═╡ 799026ed-92f0-439a-a7e3-bd362eb18b99
md"""
## Online Solvers
Online methods create a *planner* instead of a *policy* because we do not do any actual work when calling `solve` but instead plan out the solution.
Online methods solve for the best action given the current state instead of solving for all states.
"""

# ╔═╡ 3484668f-9cdb-4ac9-b683-8054f0ea9d7e
md"""
### Monte Carlo Tree Search
*Monte Carlo tree search* (MCTS)$^5$ is an anytime online algorithm that uses simulated rollouts of a random policy to estimate the value of each state-action node in a tree.

The four main stages of the algorithm are shown in the diagram below.
"""

# ╔═╡ 105a8fb9-008c-4ae1-83e8-8894209ada0e
html"""
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="512.428pt" height="184.382pt" viewBox="0 0 512.428 184.382" version="1.1">
<defs>
<g>
<symbol overflow="visible" id="glyph0-0">
<path style="stroke:none;" d=""/>
</symbol>
<symbol overflow="visible" id="glyph0-1">
<path style="stroke:none;" d="M 5.515625 -2 C 5.515625 -2.796875 4.890625 -3.921875 3.78125 -4.1875 L 2.4375 -4.515625 C 1.5625 -4.71875 1.5 -5.25 1.5 -5.609375 C 1.5 -6.28125 1.921875 -6.75 2.765625 -6.75 C 4.140625 -6.75 4.515625 -5.90625 4.65625 -4.890625 C 4.671875 -4.75 4.828125 -4.546875 4.9375 -4.546875 C 5.078125 -4.546875 5.21875 -4.75 5.21875 -4.9375 L 5.21875 -6.953125 C 5.21875 -7.125 5.078125 -7.359375 4.96875 -7.359375 C 4.890625 -7.359375 4.78125 -7.296875 4.703125 -7.171875 L 4.421875 -6.71875 C 4.28125 -6.859375 3.71875 -7.359375 2.765625 -7.359375 C 1.609375 -7.359375 0.5625 -6.3125 0.5625 -5.25 C 0.5625 -4.609375 0.953125 -4.0625 1.078125 -3.90625 C 1.546875 -3.421875 1.953125 -3.296875 2.78125 -3.09375 C 2.9375 -3.0625 3.109375 -3.03125 3.265625 -2.984375 C 3.859375 -2.84375 3.953125 -2.84375 4.25 -2.515625 C 4.3125 -2.4375 4.5625 -2.21875 4.5625 -1.671875 C 4.5625 -0.96875 4.203125 -0.421875 3.296875 -0.421875 C 2.875 -0.421875 2.296875 -0.453125 1.75 -0.875 C 1.109375 -1.390625 1.125 -2 1.109375 -2.328125 C 1.109375 -2.40625 0.890625 -2.59375 0.84375 -2.59375 C 0.71875 -2.59375 0.5625 -2.359375 0.5625 -2.171875 L 0.5625 -0.171875 C 0.5625 -0.015625 0.71875 0.21875 0.828125 0.21875 C 0.890625 0.21875 1.015625 0.140625 1.078125 0.046875 L 1.359375 -0.40625 C 1.515625 -0.265625 2.265625 0.21875 3.296875 0.21875 C 4.546875 0.21875 5.515625 -0.953125 5.515625 -2 Z M 5.515625 -2 "/>
</symbol>
<symbol overflow="visible" id="glyph0-2">
<path style="stroke:none;" d="M 5.28125 -2.265625 L 4.890625 -2.265625 C 4.6875 -0.890625 4.609375 -0.578125 3.34375 -0.578125 L 2.265625 -0.578125 C 1.90625 -0.578125 2.015625 -0.4375 2.015625 -0.84375 L 2.015625 -2.515625 L 2.5625 -2.515625 C 3.296875 -2.515625 3.265625 -2.484375 3.265625 -1.65625 L 3.8125 -1.65625 L 3.8125 -3.96875 L 3.265625 -3.96875 C 3.265625 -3.125 3.296875 -3.09375 2.5625 -3.09375 L 2.015625 -3.09375 L 2.015625 -4.578125 C 2.015625 -4.96875 1.90625 -4.84375 2.265625 -4.84375 L 3.28125 -4.84375 C 4.4375 -4.84375 4.53125 -4.65625 4.671875 -3.40625 L 5.21875 -3.40625 L 5 -5.421875 L 0.265625 -5.421875 L 0.265625 -4.84375 C 1.09375 -4.84375 0.984375 -4.9375 0.984375 -4.53125 L 0.984375 -0.875 C 0.984375 -0.46875 1.09375 -0.578125 0.265625 -0.578125 L 0.265625 0 L 5.109375 0 L 5.4375 -2.265625 Z M 5.28125 -2.265625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-3">
<path style="stroke:none;" d="M 4.71875 -2.265625 L 4.328125 -2.265625 C 4.234375 -1.296875 4.28125 -0.578125 2.890625 -0.578125 L 2.265625 -0.578125 C 1.90625 -0.578125 2.015625 -0.4375 2.015625 -0.84375 L 2.015625 -4.53125 C 2.015625 -5.03125 2.015625 -4.875 2.90625 -4.875 L 2.90625 -5.46875 L 1.53125 -5.421875 L 0.265625 -5.46875 L 0.265625 -4.875 C 1.09375 -4.875 0.984375 -4.96875 0.984375 -4.5625 L 0.984375 -0.875 C 0.984375 -0.46875 1.09375 -0.578125 0.265625 -0.578125 L 0.265625 0 L 4.65625 0 L 4.875 -2.265625 Z M 4.71875 -2.265625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-4">
<path style="stroke:none;" d="M 5.53125 -1.921875 C 5.53125 -2.015625 5.390625 -2.25 5.25 -2.25 C 5.140625 -2.25 4.984375 -2.03125 4.96875 -1.921875 C 4.90625 -0.875 4.203125 -0.4375 3.375 -0.4375 C 2.875 -0.4375 1.515625 -0.53125 1.515625 -2.71875 C 1.515625 -4.9375 2.90625 -5.015625 3.359375 -5.015625 C 4.09375 -5.015625 4.78125 -4.65625 4.96875 -3.390625 C 4.984375 -3.3125 5.15625 -3.09375 5.25 -3.09375 C 5.390625 -3.09375 5.53125 -3.3125 5.53125 -3.5 L 5.53125 -5.1875 C 5.53125 -5.34375 5.390625 -5.59375 5.28125 -5.59375 C 5.21875 -5.59375 5.109375 -5.515625 5.03125 -5.421875 L 4.71875 -5.046875 C 4.640625 -5.140625 4.046875 -5.59375 3.296875 -5.59375 C 1.796875 -5.59375 0.34375 -4.234375 0.34375 -2.71875 C 0.34375 -1.203125 1.796875 0.140625 3.296875 0.140625 C 4.59375 0.140625 5.53125 -1.0625 5.53125 -1.921875 Z M 5.53125 -1.921875 "/>
</symbol>
<symbol overflow="visible" id="glyph0-5">
<path style="stroke:none;" d="M 5.6875 -3.53125 L 5.515625 -5.390625 L 0.359375 -5.390625 L 0.1875 -3.375 L 0.734375 -3.375 C 0.84375 -4.796875 0.890625 -4.8125 2 -4.8125 C 2.5625 -4.8125 2.4375 -4.96875 2.4375 -4.546875 L 2.4375 -0.921875 C 2.4375 -0.515625 2.546875 -0.578125 1.78125 -0.578125 L 1.421875 -0.578125 L 1.421875 0.015625 C 1.96875 -0.03125 2.546875 -0.03125 2.953125 -0.03125 C 3.34375 -0.03125 3.9375 -0.03125 4.46875 0.015625 L 4.46875 -0.578125 L 4.109375 -0.578125 C 3.34375 -0.578125 3.453125 -0.515625 3.453125 -0.921875 L 3.453125 -4.546875 C 3.453125 -4.96875 3.34375 -4.8125 3.890625 -4.8125 C 4.96875 -4.8125 5.03125 -4.8125 5.140625 -3.375 L 5.6875 -3.375 Z M 5.6875 -3.53125 "/>
</symbol>
<symbol overflow="visible" id="glyph0-6">
<path style="stroke:none;" d="M 2.765625 -0.15625 L 2.765625 -0.578125 C 1.90625 -0.578125 2.015625 -0.453125 2.015625 -0.890625 L 2.015625 -4.5625 C 2.015625 -4.984375 1.90625 -4.875 2.765625 -4.875 L 2.765625 -5.46875 L 1.5 -5.421875 L 0.234375 -5.46875 L 0.234375 -4.875 C 1.09375 -4.875 0.984375 -4.984375 0.984375 -4.5625 L 0.984375 -0.890625 C 0.984375 -0.453125 1.09375 -0.578125 0.234375 -0.578125 L 0.234375 0.015625 L 1.5 -0.03125 L 2.765625 0.015625 Z M 2.765625 -0.15625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-7">
<path style="stroke:none;" d="M 5.984375 -2.703125 C 5.984375 -4.1875 4.640625 -5.59375 3.171875 -5.59375 C 1.6875 -5.59375 0.34375 -4.1875 0.34375 -2.703125 C 0.34375 -1.203125 1.71875 0.140625 3.171875 0.140625 C 4.625 0.140625 5.984375 -1.203125 5.984375 -2.703125 Z M 4.8125 -2.8125 C 4.8125 -0.84375 3.875 -0.453125 3.171875 -0.453125 C 2.46875 -0.453125 1.515625 -0.84375 1.515625 -2.8125 C 1.515625 -4.6875 2.5 -5.015625 3.171875 -5.015625 C 3.84375 -5.015625 4.8125 -4.671875 4.8125 -2.8125 Z M 4.8125 -2.8125 "/>
</symbol>
<symbol overflow="visible" id="glyph0-8">
<path style="stroke:none;" d="M 5.828125 -5.03125 L 5.828125 -5.46875 L 4.828125 -5.421875 C 4.671875 -5.421875 4.21875 -5.4375 3.8125 -5.46875 L 3.8125 -4.875 C 4.6875 -4.875 4.53125 -4.5 4.53125 -4.28125 L 4.53125 -1.3125 L 4.78125 -1.4375 L 2.03125 -5.28125 C 1.9375 -5.40625 1.8125 -5.453125 1.625 -5.453125 L 0.265625 -5.453125 L 0.265625 -4.875 C 0.671875 -4.875 0.953125 -4.875 0.984375 -4.859375 L 0.984375 -1.171875 C 0.984375 -0.9375 1.140625 -0.578125 0.265625 -0.578125 L 0.265625 0.015625 L 1.28125 -0.03125 C 1.4375 -0.03125 1.890625 -0.015625 2.296875 0.015625 L 2.296875 -0.578125 C 1.421875 -0.578125 1.578125 -0.9375 1.578125 -1.171875 L 1.578125 -4.734375 L 1.3125 -4.625 L 1.421875 -4.5 L 4.546875 -0.15625 C 4.625 -0.046875 4.765625 0 4.828125 0 C 4.96875 0 5.109375 -0.234375 5.109375 -0.421875 L 5.109375 -4.28125 C 5.109375 -4.5 4.96875 -4.875 5.828125 -4.875 Z M 5.828125 -5.03125 "/>
</symbol>
<symbol overflow="visible" id="glyph0-9">
<path style="stroke:none;" d="M 6.953125 -2.90625 L 6.578125 -2.90625 C 6.296875 -1.203125 6.21875 -0.640625 4.453125 -0.640625 L 2.953125 -0.640625 C 2.484375 -0.640625 2.609375 -0.53125 2.609375 -0.875 L 2.609375 -3.375 L 3.4375 -3.375 C 4.421875 -3.375 4.40625 -3.234375 4.40625 -2.203125 L 4.96875 -2.203125 L 4.96875 -5.171875 L 4.40625 -5.171875 C 4.40625 -4.140625 4.421875 -4 3.4375 -4 L 2.609375 -4 L 2.609375 -6.234375 C 2.609375 -6.5625 2.484375 -6.46875 2.953125 -6.46875 L 4.375 -6.46875 C 5.9375 -6.46875 6.09375 -6.125 6.28125 -4.53125 L 6.84375 -4.53125 L 6.515625 -7.109375 L 0.390625 -7.109375 L 0.390625 -6.46875 L 0.78125 -6.46875 C 1.5625 -6.46875 1.421875 -6.515625 1.421875 -6.15625 L 1.421875 -0.9375 C 1.421875 -0.578125 1.5625 -0.640625 0.78125 -0.640625 L 0.390625 -0.640625 L 0.390625 0 L 6.65625 0 L 7.125 -2.90625 Z M 6.953125 -2.90625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-10">
<path style="stroke:none;" d="M 5.96875 -0.15625 L 5.96875 -0.578125 C 5.53125 -0.578125 5.40625 -0.53125 5.21875 -0.6875 C 5.078125 -0.8125 3.5 -3.015625 3.484375 -3.046875 L 4.40625 -4.3125 C 4.75 -4.75 5.046875 -4.859375 5.640625 -4.875 L 5.640625 -5.46875 C 5.25 -5.4375 4.9375 -5.421875 4.6875 -5.421875 L 3.609375 -5.46875 L 3.609375 -4.890625 C 3.921875 -4.859375 3.90625 -4.9375 3.90625 -4.6875 C 3.90625 -4.515625 3.875 -4.515625 3.8125 -4.4375 L 3.125 -3.515625 L 2.28125 -4.671875 C 2.1875 -4.78125 2.25 -4.71875 2.25 -4.75 C 2.25 -4.921875 2.234375 -4.859375 2.578125 -4.875 L 2.578125 -5.46875 L 1.359375 -5.421875 C 1.09375 -5.421875 0.703125 -5.4375 0.234375 -5.46875 L 0.234375 -4.875 C 0.984375 -4.875 0.953125 -4.859375 1.21875 -4.46875 L 2.515625 -2.703125 L 1.453125 -1.265625 C 1.171875 -0.890625 0.953125 -0.59375 0.125 -0.578125 L 0.125 0.015625 C 0.53125 -0.015625 0.84375 -0.03125 1.09375 -0.03125 C 1.421875 -0.03125 1.875 -0.015625 2.15625 0.015625 L 2.15625 -0.5625 C 1.8125 -0.59375 1.859375 -0.5625 1.859375 -0.75 C 1.859375 -0.921875 1.890625 -0.921875 2.046875 -1.140625 C 2.359375 -1.5625 2.65625 -1.96875 2.859375 -2.234375 L 3.953125 -0.75 C 3.984375 -0.703125 3.96875 -0.75 3.96875 -0.671875 C 3.96875 -0.609375 4.078125 -0.59375 3.640625 -0.5625 L 3.640625 0.015625 L 4.875 -0.03125 C 5.109375 -0.03125 5.515625 -0.015625 5.96875 0.015625 Z M 5.96875 -0.15625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-11">
<path style="stroke:none;" d="M 5.203125 -3.875 C 5.203125 -4.59375 4.296875 -5.453125 3.15625 -5.453125 L 0.296875 -5.453125 L 0.296875 -4.875 C 1.109375 -4.875 1 -4.96875 1 -4.5625 L 1 -0.875 C 1 -0.46875 1.109375 -0.578125 0.296875 -0.578125 L 0.296875 0.015625 L 1.53125 -0.03125 L 2.75 0.015625 L 2.75 -0.578125 C 1.9375 -0.578125 2.03125 -0.46875 2.03125 -0.875 L 2.03125 -2.328125 L 3.21875 -2.328125 C 4.21875 -2.328125 5.203125 -3.125 5.203125 -3.875 Z M 4.03125 -3.875 C 4.03125 -3.484375 4.203125 -2.890625 2.9375 -2.890625 L 2 -2.890625 L 2 -4.609375 C 2 -5 1.90625 -4.875 2.25 -4.875 L 2.9375 -4.875 C 4.203125 -4.875 4.03125 -4.28125 4.03125 -3.875 Z M 4.03125 -3.875 "/>
</symbol>
<symbol overflow="visible" id="glyph0-12">
<path style="stroke:none;" d="M 5.921875 -0.15625 L 5.921875 -0.578125 C 5.21875 -0.578125 5.28125 -0.453125 5.140625 -0.8125 L 3.421875 -5.234375 C 3.375 -5.390625 3.171875 -5.625 3.0625 -5.625 C 2.921875 -5.625 2.734375 -5.390625 2.6875 -5.265625 L 1.09375 -1.140625 C 0.984375 -0.875 0.96875 -0.59375 0.171875 -0.578125 L 0.171875 0.015625 C 0.5625 -0.015625 0.84375 -0.03125 1.0625 -0.03125 L 2.046875 0.015625 L 2.046875 -0.578125 C 1.46875 -0.59375 1.59375 -0.765625 1.59375 -0.859375 C 1.59375 -0.9375 1.59375 -0.953125 1.859375 -1.6875 L 3.765625 -1.6875 L 3.90625 -1.28125 C 3.984375 -1.09375 4.109375 -0.75 4.109375 -0.6875 C 4.109375 -0.40625 3.921875 -0.578125 3.59375 -0.578125 L 3.59375 0.015625 L 4.8125 -0.03125 C 5.140625 -0.03125 5.53125 -0.015625 5.921875 0.015625 Z M 3.75 -2.265625 L 2.09375 -2.265625 L 2.96875 -4.5 L 2.65625 -4.5 L 3.53125 -2.265625 Z M 3.75 -2.265625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-13">
<path style="stroke:none;" d="M 4.203125 -1.578125 C 4.203125 -2.203125 3.765625 -2.5 3.765625 -2.5 L 3.765625 -2.734375 C 3.40625 -3.109375 3.140625 -3.1875 2.296875 -3.390625 C 2.078125 -3.4375 1.734375 -3.515625 1.671875 -3.53125 C 1.171875 -3.734375 1.171875 -3.953125 1.171875 -4.25 C 1.171875 -4.71875 1.421875 -5.046875 2.078125 -5.046875 C 3.34375 -5.046875 3.375 -4.03125 3.40625 -3.71875 C 3.421875 -3.65625 3.59375 -3.421875 3.703125 -3.421875 C 3.828125 -3.421875 3.984375 -3.640625 3.984375 -3.828125 L 3.984375 -5.1875 C 3.984375 -5.34375 3.828125 -5.59375 3.734375 -5.59375 C 3.671875 -5.59375 3.546875 -5.53125 3.40625 -5.3125 C 3.34375 -5.265625 3.25 -5.109375 3.296875 -5.1875 C 3.046875 -5.421875 2.484375 -5.59375 2.078125 -5.59375 C 1.171875 -5.59375 0.34375 -4.75 0.34375 -3.96875 C 0.34375 -3.40625 0.71875 -2.96875 0.84375 -2.84375 C 1.140625 -2.546875 1.453125 -2.46875 2.359375 -2.25 C 2.90625 -2.125 2.890625 -2.15625 3.125 -1.9375 C 3.171875 -1.90625 3.390625 -1.75 3.390625 -1.3125 C 3.390625 -0.8125 3.15625 -0.4375 2.46875 -0.4375 C 2.21875 -0.4375 1.78125 -0.421875 1.34375 -0.78125 C 0.890625 -1.125 0.921875 -1.5 0.90625 -1.765625 C 0.890625 -1.84375 0.671875 -2.03125 0.640625 -2.03125 C 0.515625 -2.03125 0.34375 -1.78125 0.34375 -1.609375 L 0.34375 -0.265625 C 0.34375 -0.09375 0.515625 0.140625 0.609375 0.140625 C 0.671875 0.140625 0.78125 0.078125 0.921875 -0.140625 C 0.984375 -0.1875 1.078125 -0.34375 1.03125 -0.28125 C 1.203125 -0.140625 1.828125 0.140625 2.46875 0.140625 C 3.4375 0.140625 4.203125 -0.78125 4.203125 -1.578125 Z M 4.203125 -1.578125 "/>
</symbol>
<symbol overflow="visible" id="glyph0-14">
<path style="stroke:none;" d="M 7.125 -0.15625 L 7.125 -0.578125 C 6.3125 -0.578125 6.40625 -0.46875 6.40625 -0.875 L 6.40625 -4.5625 C 6.40625 -4.96875 6.3125 -4.875 7.125 -4.875 L 7.125 -5.453125 L 5.765625 -5.453125 C 5.546875 -5.453125 5.359375 -5.28125 5.28125 -5.09375 L 3.5625 -0.90625 L 3.875 -0.90625 L 2.15625 -5.109375 C 2.09375 -5.28125 1.890625 -5.453125 1.671875 -5.453125 L 0.3125 -5.453125 L 0.3125 -4.875 C 1.140625 -4.875 1.03125 -4.96875 1.03125 -4.5625 L 1.03125 -1.171875 C 1.03125 -0.9375 1.1875 -0.578125 0.3125 -0.578125 L 0.3125 0.015625 L 1.328125 -0.03125 C 1.46875 -0.03125 1.9375 -0.015625 2.328125 0.015625 L 2.328125 -0.578125 C 1.46875 -0.578125 1.609375 -0.9375 1.609375 -1.171875 L 1.609375 -4.84375 L 1.421875 -4.671875 L 3.1875 -0.34375 C 3.21875 -0.25 3.421875 0 3.53125 0 C 3.625 0 3.828125 -0.25 3.875 -0.34375 L 5.65625 -4.734375 L 5.46875 -4.921875 L 5.46875 -0.875 C 5.46875 -0.46875 5.578125 -0.578125 4.75 -0.578125 L 4.75 0.015625 L 5.9375 -0.03125 C 6.296875 -0.03125 6.65625 -0.015625 7.125 0.015625 Z M 7.125 -0.15625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-15">
<path style="stroke:none;" d="M 5.828125 -5.03125 L 5.828125 -5.46875 C 5.4375 -5.4375 4.90625 -5.421875 4.84375 -5.421875 C 4.5625 -5.421875 4.28125 -5.4375 3.84375 -5.46875 L 3.84375 -4.875 C 4.71875 -4.875 4.5625 -4.5 4.5625 -4.28125 L 4.5625 -1.9375 C 4.5625 -0.78125 3.859375 -0.4375 3.1875 -0.4375 C 2.875 -0.4375 2.015625 -0.390625 2.015625 -1.890625 L 2.015625 -4.5625 C 2.015625 -4.96875 1.90625 -4.875 2.734375 -4.875 L 2.734375 -5.46875 L 1.5 -5.421875 L 0.265625 -5.46875 L 0.265625 -4.875 C 1.109375 -4.875 0.984375 -4.96875 0.984375 -4.546875 L 0.984375 -2.375 C 0.984375 -2.140625 0.984375 -1.765625 1 -1.640625 C 1.09375 -0.828125 2.046875 0.140625 3.15625 0.140625 C 4.3125 0.140625 5.109375 -1.03125 5.109375 -1.765625 L 5.109375 -4.421875 C 5.125 -4.8125 5.234375 -4.875 5.828125 -4.875 Z M 5.828125 -5.03125 "/>
</symbol>
<symbol overflow="visible" id="glyph0-16">
<path style="stroke:none;" d="M 4.9375 -7.4375 C 4.9375 -7.546875 4.6875 -7.8125 4.578125 -7.8125 C 4.453125 -7.8125 4.25 -7.546875 4.21875 -7.4375 L 0.609375 1.953125 C 0.5625 2.078125 0.8125 2.25 0.8125 2.25 L 0.5625 2.140625 C 0.5625 2.25 0.8125 2.5 0.921875 2.5 C 1.046875 2.5 1.234375 2.25 1.28125 2.140625 L 4.890625 -7.25 C 4.9375 -7.375 4.890625 -7.328125 4.890625 -7.328125 Z M 4.9375 -7.4375 "/>
</symbol>
<symbol overflow="visible" id="glyph0-17">
<path style="stroke:none;" d="M 7.9375 -1.03125 C 7.9375 -1.09375 7.796875 -1.375 7.671875 -1.375 C 7.5625 -1.375 7.390625 -1.109375 7.390625 -1.046875 C 7.3125 -0.265625 7.0625 -0.328125 6.84375 -0.328125 C 6.3125 -0.328125 6.40625 -0.609375 6.21875 -1.765625 C 6.109375 -2.46875 6.015625 -2.828125 5.703125 -3.15625 C 5.5 -3.375 5.078125 -3.609375 4.6875 -3.71875 L 4.6875 -3.390625 C 5.875 -3.671875 6.671875 -4.5 6.671875 -5.171875 C 6.671875 -6.140625 5.296875 -7.140625 3.796875 -7.140625 L 0.40625 -7.140625 L 0.40625 -6.5 L 0.8125 -6.5 C 1.578125 -6.5 1.4375 -6.546875 1.4375 -6.1875 L 1.4375 -0.9375 C 1.4375 -0.578125 1.578125 -0.640625 0.8125 -0.640625 L 0.40625 -0.640625 L 0.40625 0.015625 C 0.921875 -0.03125 1.640625 -0.03125 2.03125 -0.03125 C 2.40625 -0.03125 3.125 -0.03125 3.625 0.015625 L 3.625 -0.640625 L 3.234375 -0.640625 C 2.46875 -0.640625 2.609375 -0.578125 2.609375 -0.9375 L 2.609375 -3.296875 L 3.703125 -3.296875 C 4.234375 -3.296875 4.453125 -3.15625 4.609375 -2.984375 C 5 -2.625 4.9375 -2.484375 4.9375 -1.78125 C 4.9375 -1.09375 5 -0.625 5.421875 -0.234375 C 5.796875 0.078125 6.453125 0.21875 6.8125 0.21875 C 7.609375 0.21875 7.9375 -0.75 7.9375 -1.03125 Z M 5.328125 -5.171875 C 5.328125 -4.109375 4.78125 -3.84375 3.65625 -3.84375 L 2.609375 -3.84375 L 2.609375 -6.265625 C 2.609375 -6.53125 2.46875 -6.453125 2.71875 -6.484375 C 2.796875 -6.5 3.109375 -6.5 3.3125 -6.5 C 4.171875 -6.5 5.328125 -6.65625 5.328125 -5.171875 Z M 5.328125 -5.171875 "/>
</symbol>
<symbol overflow="visible" id="glyph0-18">
<path style="stroke:none;" d="M 7.109375 -1.984375 C 7.109375 -2.828125 6.15625 -3.765625 4.921875 -3.890625 L 4.921875 -3.5625 C 5.890625 -3.734375 6.8125 -4.515625 6.8125 -5.28125 C 6.8125 -6.171875 5.6875 -7.140625 4.34375 -7.140625 L 0.421875 -7.140625 L 0.421875 -6.5 L 0.8125 -6.5 C 1.578125 -6.5 1.453125 -6.546875 1.453125 -6.1875 L 1.453125 -0.9375 C 1.453125 -0.578125 1.578125 -0.640625 0.8125 -0.640625 L 0.421875 -0.640625 L 0.421875 0 L 4.625 0 C 6 0 7.109375 -1.046875 7.109375 -1.984375 Z M 5.546875 -5.28125 C 5.546875 -4.578125 5.109375 -3.984375 3.984375 -3.984375 L 2.578125 -3.984375 L 2.578125 -6.265625 C 2.578125 -6.59375 2.453125 -6.5 2.921875 -6.5 L 4.28125 -6.5 C 5.296875 -6.5 5.546875 -5.84375 5.546875 -5.28125 Z M 5.796875 -2 C 5.796875 -1.25 5.359375 -0.640625 4.296875 -0.640625 L 2.921875 -0.640625 C 2.453125 -0.640625 2.578125 -0.53125 2.578125 -0.875 L 2.578125 -3.421875 L 4.4375 -3.421875 C 5.46875 -3.421875 5.796875 -2.703125 5.796875 -2 Z M 5.796875 -2 "/>
</symbol>
<symbol overflow="visible" id="glyph0-19">
<path style="stroke:none;" d="M 6.078125 -0.15625 L 6.078125 -0.578125 C 5.609375 -0.578125 5.5 -0.5625 5.125 -1.0625 L 3.515625 -3.265625 C 5.28125 -4.890625 5.390625 -4.84375 5.96875 -4.890625 L 5.96875 -5.46875 C 5.59375 -5.4375 5.4375 -5.421875 5.1875 -5.421875 C 4.921875 -5.421875 4.40625 -5.4375 4.109375 -5.46875 L 4.109375 -4.890625 C 4.375 -4.859375 4.28125 -4.953125 4.28125 -4.84375 C 4.28125 -4.671875 4.15625 -4.578125 4 -4.4375 L 2.015625 -2.703125 L 2.015625 -4.5625 C 2.015625 -4.96875 1.90625 -4.875 2.734375 -4.875 L 2.734375 -5.46875 L 1.5 -5.421875 L 0.265625 -5.46875 L 0.265625 -4.875 C 1.09375 -4.875 0.984375 -4.96875 0.984375 -4.5625 L 0.984375 -0.875 C 0.984375 -0.46875 1.09375 -0.578125 0.265625 -0.578125 L 0.265625 0.015625 L 1.5 -0.03125 L 2.734375 0.015625 L 2.734375 -0.578125 C 1.90625 -0.578125 2.015625 -0.46875 2.015625 -0.875 L 2.015625 -1.9375 L 2.796875 -2.625 L 4.03125 -0.96875 C 4.140625 -0.84375 4.203125 -0.75 4.203125 -0.625 C 4.203125 -0.421875 4.125 -0.578125 3.890625 -0.578125 L 3.890625 0.015625 L 5.078125 -0.03125 C 5.359375 -0.03125 5.65625 -0.015625 6.078125 0.015625 Z M 6.078125 -0.15625 "/>
</symbol>
<symbol overflow="visible" id="glyph0-20">
<path style="stroke:none;" d="M 6.0625 -0.84375 C 6.0625 -0.890625 5.90625 -1.15625 5.78125 -1.15625 C 5.671875 -1.15625 5.5 -0.890625 5.5 -0.859375 C 5.4375 -0.25 5.234375 -0.40625 5.15625 -0.40625 C 4.96875 -0.40625 4.96875 -0.484375 4.921875 -0.59375 C 4.828125 -0.75 4.828125 -0.921875 4.6875 -1.5625 C 4.609375 -1.90625 4.359375 -2.578125 3.625 -2.875 L 3.625 -2.546875 C 4.3125 -2.71875 5.078125 -3.328125 5.078125 -3.9375 C 5.078125 -4.640625 4.046875 -5.453125 2.84375 -5.453125 L 0.296875 -5.453125 L 0.296875 -4.875 C 1.109375 -4.875 1 -4.96875 1 -4.5625 L 1 -0.875 C 1 -0.46875 1.109375 -0.578125 0.296875 -0.578125 L 0.296875 0.015625 L 1.5 -0.03125 L 2.71875 0.015625 L 2.71875 -0.578125 C 1.90625 -0.578125 2 -0.46875 2 -0.875 L 2 -2.453125 L 2.75 -2.453125 C 3 -2.453125 3.15625 -2.5 3.453125 -2.1875 C 3.671875 -1.96875 3.625 -1.828125 3.625 -1.390625 C 3.625 -0.84375 3.671875 -0.546875 3.984375 -0.234375 C 4.171875 -0.0625 4.671875 0.140625 5.125 0.140625 C 5.765625 0.140625 6.0625 -0.640625 6.0625 -0.84375 Z M 3.921875 -3.9375 C 3.921875 -3.546875 4.03125 -3 2.734375 -3 L 2 -3 L 2 -4.609375 C 2 -4.859375 1.96875 -4.84375 2 -4.859375 C 2.046875 -4.875 2.3125 -4.875 2.5 -4.875 C 3.234375 -4.875 3.921875 -5 3.921875 -3.9375 Z M 3.921875 -3.9375 "/>
</symbol>
<symbol overflow="visible" id="glyph0-21">
<path style="stroke:none;" d="M 6.078125 -1.96875 L 6.078125 -2.40625 C 5.609375 -2.375 5.203125 -2.359375 4.9375 -2.359375 C 4.578125 -2.359375 4 -2.359375 3.5 -2.40625 L 3.5 -1.8125 L 3.859375 -1.8125 C 4.609375 -1.8125 4.5 -1.859375 4.5 -1.46875 L 4.5 -1.171875 C 4.5 -0.9375 4.546875 -0.8125 4.140625 -0.59375 C 3.921875 -0.453125 3.703125 -0.4375 3.40625 -0.4375 C 2.796875 -0.4375 1.515625 -0.59375 1.515625 -2.71875 C 1.515625 -4.90625 2.875 -5.015625 3.359375 -5.015625 C 4.09375 -5.015625 4.765625 -4.65625 4.953125 -3.390625 C 4.96875 -3.3125 5.140625 -3.09375 5.25 -3.09375 C 5.375 -3.09375 5.515625 -3.3125 5.515625 -3.5 L 5.515625 -5.1875 C 5.515625 -5.34375 5.375 -5.59375 5.28125 -5.59375 C 5.21875 -5.59375 5.09375 -5.515625 5.015625 -5.421875 L 4.71875 -5.046875 C 4.46875 -5.328125 3.84375 -5.59375 3.296875 -5.59375 C 1.796875 -5.59375 0.34375 -4.25 0.34375 -2.71875 C 0.34375 -1.234375 1.75 0.140625 3.3125 0.140625 C 3.65625 0.140625 4.5 0.046875 4.78125 -0.34375 C 4.765625 -0.375 5.171875 -0.015625 5.28125 -0.015625 C 5.375 -0.015625 5.515625 -0.25 5.515625 -0.40625 L 5.515625 -1.53125 C 5.515625 -1.90625 5.40625 -1.8125 6.078125 -1.8125 Z M 6.078125 -1.96875 "/>
</symbol>
<symbol overflow="visible" id="glyph1-0">
<path style="stroke:none;" d=""/>
</symbol>
<symbol overflow="visible" id="glyph1-1">
<path style="stroke:none;" d="M 4.359375 -0.0625 C 5.90625 -0.640625 7.375 -2.421875 7.375 -4.34375 C 7.375 -5.953125 6.3125 -7.03125 4.828125 -7.03125 C 2.6875 -7.03125 0.484375 -4.765625 0.484375 -2.4375 C 0.484375 -0.78125 1.609375 0.21875 3.046875 0.21875 C 3.296875 0.21875 3.625 0.171875 4.015625 0.0625 C 3.984375 0.6875 3.984375 0.703125 3.984375 0.84375 C 3.984375 1.15625 3.984375 1.9375 4.8125 1.9375 C 5.984375 1.9375 6.46875 0.109375 6.46875 0 C 6.46875 -0.0625 6.40625 -0.09375 6.359375 -0.09375 C 6.28125 -0.09375 6.265625 -0.046875 6.234375 0.015625 C 6 0.71875 5.421875 0.96875 5.078125 0.96875 C 4.609375 0.96875 4.46875 0.703125 4.359375 -0.0625 Z M 2.484375 -0.140625 C 1.703125 -0.453125 1.359375 -1.21875 1.359375 -2.125 C 1.359375 -2.8125 1.625 -4.234375 2.375 -5.296875 C 3.109375 -6.3125 4.046875 -6.78125 4.78125 -6.78125 C 5.765625 -6.78125 6.5 -6 6.5 -4.671875 C 6.5 -3.671875 5.984375 -1.328125 4.3125 -0.40625 C 4.265625 -0.75 4.171875 -1.46875 3.4375 -1.46875 C 2.90625 -1.46875 2.421875 -0.984375 2.421875 -0.453125 C 2.421875 -0.265625 2.484375 -0.15625 2.484375 -0.140625 Z M 3.09375 -0.03125 C 2.953125 -0.03125 2.640625 -0.03125 2.640625 -0.453125 C 2.640625 -0.859375 3.015625 -1.25 3.4375 -1.25 C 3.859375 -1.25 4.046875 -1.015625 4.046875 -0.40625 C 4.046875 -0.265625 4.03125 -0.25 3.9375 -0.203125 C 3.671875 -0.09375 3.375 -0.03125 3.09375 -0.03125 Z M 3.09375 -0.03125 "/>
</symbol>
</g>
<clipPath id="clip1">
  <path d="M 279 109 L 330 109 L 330 184.382813 L 279 184.382813 Z M 279 109 "/>
</clipPath>
<clipPath id="clip2">
  <path d="M 489 76 L 512.429688 76 L 512.429688 106 L 489 106 Z M 489 76 "/>
</clipPath>
</defs>
<g id="surface1">
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 8.503469 -0.0019375 C 8.503469 4.697281 4.694875 8.505875 -0.0004375 8.505875 C -4.69575 8.505875 -8.504344 4.697281 -8.504344 -0.0019375 C -8.504344 -4.69725 -4.69575 -8.505844 -0.0004375 -8.505844 C 4.694875 -8.505844 8.503469 -4.69725 8.503469 -0.0019375 Z M 8.503469 -0.0019375 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-1" x="34.955" y="11.906"/>
  <use xlink:href="#glyph0-2" x="41.042173" y="11.906"/>
  <use xlink:href="#glyph0-3" x="46.601326" y="11.906"/>
  <use xlink:href="#glyph0-2" x="51.71216" y="11.906"/>
  <use xlink:href="#glyph0-4" x="57.271314" y="11.906"/>
  <use xlink:href="#glyph0-5" x="63.159234" y="11.906"/>
  <use xlink:href="#glyph0-6" x="69.047154" y="11.906"/>
  <use xlink:href="#glyph0-7" x="72.055871" y="11.906"/>
  <use xlink:href="#glyph0-8" x="78.39211" y="11.906"/>
</g>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -42.519969 -40.904281 L -25.512156 -40.904281 L -25.512156 -23.896469 L -42.519969 -23.896469 Z M -42.519969 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.79701;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -6.516063 -6.208969 L -21.637156 -20.611312 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 34.714844 50.035156 C 35.890625 49.269531 38.054688 48.285156 39.804688 47.871094 L 37.125 45.058594 C 36.625 46.785156 35.535156 48.894531 34.714844 50.035156 "/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -42.519969 -64.798812 C -42.519969 -60.1035 -46.328563 -56.294906 -51.023875 -56.294906 C -55.719188 -56.294906 -59.527781 -60.1035 -59.527781 -64.798812 C -59.527781 -69.498031 -55.719188 -73.302719 -51.023875 -73.302719 C -46.328563 -73.302719 -42.519969 -69.498031 -42.519969 -64.798812 Z M -42.519969 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -38.738719 -41.404281 L -46.980906 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -8.504344 -64.798812 C -8.504344 -60.1035 -12.312938 -56.294906 -17.00825 -56.294906 C -21.703563 -56.294906 -25.512156 -60.1035 -25.512156 -64.798812 C -25.512156 -69.498031 -21.703563 -73.302719 -17.00825 -73.302719 C -12.312938 -73.302719 -8.504344 -69.498031 -8.504344 -64.798812 Z M -8.504344 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:1.19553;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -29.293406 -41.404281 L -23.859813 -51.748031 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 38.535156 83.039063 C 38.027344 81.386719 37.589844 78.496094 37.6875 76.28125 L 33.453125 78.503906 C 35.332031 79.679688 37.460938 81.683594 38.535156 83.039063 "/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -8.504344 -40.904281 L 8.503469 -40.904281 L 8.503469 -23.896469 L -8.504344 -23.896469 Z M -8.504344 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M -0.0004375 -9.001937 L -0.0004375 -23.69725 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 25.511281 -40.904281 L 42.519094 -40.904281 L 42.519094 -23.896469 L 25.511281 -23.896469 Z M 25.511281 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 6.519094 -6.208969 L 25.312062 -24.111312 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 25.511281 -64.798812 C 25.511281 -60.1035 21.706594 -56.294906 17.007375 -56.294906 C 12.312062 -56.294906 8.503469 -60.1035 8.503469 -64.798812 C 8.503469 -69.498031 12.312062 -73.302719 17.007375 -73.302719 C 21.706594 -73.302719 25.511281 -69.498031 25.511281 -64.798812 Z M 25.511281 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 29.448781 -41.1035 L 21.05425 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 59.526906 -64.798812 C 59.526906 -60.1035 55.722219 -56.294906 51.023 -56.294906 C 46.327687 -56.294906 42.519094 -60.1035 42.519094 -64.798812 C 42.519094 -69.498031 46.327687 -73.302719 51.023 -73.302719 C 55.722219 -73.302719 59.526906 -69.498031 59.526906 -64.798812 Z M 59.526906 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 38.581594 -41.1035 L 46.980031 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 139.597219 -0.0019375 C 139.597219 4.697281 135.788625 8.505875 131.093313 8.505875 C 126.394094 8.505875 122.589406 4.697281 122.589406 -0.0019375 C 122.589406 -4.69725 126.394094 -8.505844 131.093313 -8.505844 C 135.788625 -8.505844 139.597219 -4.69725 139.597219 -0.0019375 Z M 139.597219 -0.0019375 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-9" x="165.508" y="12.12"/>
  <use xlink:href="#glyph0-10" x="172.900279" y="12.12"/>
  <use xlink:href="#glyph0-11" x="179.007377" y="12.12"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-12" x="183.899033" y="12.12"/>
  <use xlink:href="#glyph0-8" x="190.006132" y="12.12"/>
  <use xlink:href="#glyph0-13" x="196.11323" y="12.12"/>
  <use xlink:href="#glyph0-6" x="200.676119" y="12.12"/>
  <use xlink:href="#glyph0-7" x="203.684836" y="12.12"/>
  <use xlink:href="#glyph0-8" x="210.021076" y="12.12"/>
</g>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 88.573781 -40.904281 L 105.581594 -40.904281 L 105.581594 -23.896469 L 88.573781 -23.896469 Z M 88.573781 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 124.792531 -6.001937 L 105.780813 -24.111312 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 88.573781 -64.798812 C 88.573781 -60.1035 84.765187 -56.294906 80.069875 -56.294906 C 75.370656 -56.294906 71.565969 -60.1035 71.565969 -64.798812 C 71.565969 -69.498031 75.370656 -73.302719 80.069875 -73.302719 C 84.765187 -73.302719 88.573781 -69.498031 88.573781 -64.798812 Z M 88.573781 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 92.511281 -41.1035 L 84.112844 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.79701;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 122.589406 -64.798812 C 122.589406 -60.1035 118.780813 -56.294906 114.0855 -56.294906 C 109.386281 -56.294906 105.581594 -60.1035 105.581594 -64.798812 C 105.581594 -69.498031 109.386281 -73.302719 114.0855 -73.302719 C 118.780813 -73.302719 122.589406 -69.498031 122.589406 -64.798812 Z M 122.589406 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 101.644094 -41.1035 L 109.948781 -56.919906 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 105.581594 -105.705062 L 122.589406 -105.705062 L 122.589406 -88.69725 L 105.581594 -88.69725 Z M 105.581594 -105.705062 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:1.39478;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 114.0855 -73.701156 L 114.0855 -88.19725 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 122.589406 -40.904281 L 139.597219 -40.904281 L 139.597219 -23.896469 L 122.589406 -23.896469 Z M 122.589406 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 131.093313 -8.705062 L 131.093313 -23.69725 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 156.605031 -40.904281 L 173.612844 -40.904281 L 173.612844 -23.896469 L 156.605031 -23.896469 Z M 156.605031 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 137.394094 -6.001937 L 156.405813 -24.111312 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 156.605031 -64.798812 C 156.605031 -60.1035 152.796438 -56.294906 148.101125 -56.294906 C 143.405813 -56.294906 139.597219 -60.1035 139.597219 -64.798812 C 139.597219 -69.498031 143.405813 -73.302719 148.101125 -73.302719 C 152.796438 -73.302719 156.605031 -69.498031 156.605031 -64.798812 Z M 156.605031 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 160.542531 -41.1035 L 152.144094 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 190.620656 -64.798812 C 190.620656 -60.1035 186.812063 -56.294906 182.11675 -56.294906 C 177.421438 -56.294906 173.612844 -60.1035 173.612844 -64.798812 C 173.612844 -69.498031 177.421438 -73.302719 182.11675 -73.302719 C 186.812063 -73.302719 190.620656 -69.498031 190.620656 -64.798812 Z M 190.620656 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 169.675344 -41.1035 L 178.073781 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 270.390188 -0.0019375 C 270.390188 4.697281 266.581594 8.505875 261.886281 8.505875 C 257.190969 8.505875 253.382375 4.697281 253.382375 -0.0019375 C 253.382375 -4.69725 257.190969 -8.505844 261.886281 -8.505844 C 266.581594 -8.505844 270.390188 -4.69725 270.390188 -0.0019375 Z M 270.390188 -0.0019375 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-1" x="270.302" y="11.294"/>
  <use xlink:href="#glyph0-6" x="276.389173" y="11.294"/>
  <use xlink:href="#glyph0-14" x="279.39789" y="11.294"/>
  <use xlink:href="#glyph0-15" x="286.839982" y="11.294"/>
  <use xlink:href="#glyph0-3" x="292.947081" y="11.294"/>
  <use xlink:href="#glyph0-12" x="298.057915" y="11.294"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-5" x="303.497516" y="11.294"/>
  <use xlink:href="#glyph0-6" x="309.385437" y="11.294"/>
  <use xlink:href="#glyph0-7" x="312.394154" y="11.294"/>
  <use xlink:href="#glyph0-8" x="318.730393" y="11.294"/>
  <use xlink:href="#glyph0-16" x="324.837491" y="11.294"/>
  <use xlink:href="#glyph0-17" x="330.346831" y="11.294"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-7" x="338.028027" y="11.294"/>
  <use xlink:href="#glyph0-3" x="344.364266" y="11.294"/>
  <use xlink:href="#glyph0-3" x="349.4751" y="11.294"/>
  <use xlink:href="#glyph0-7" x="354.585934" y="11.294"/>
  <use xlink:href="#glyph0-15" x="360.922173" y="11.294"/>
  <use xlink:href="#glyph0-5" x="367.029272" y="11.294"/>
</g>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 219.36675 -40.904281 L 236.374563 -40.904281 L 236.374563 -23.896469 L 219.36675 -23.896469 Z M 219.36675 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 255.5855 -6.001937 L 236.573781 -24.111312 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 219.36675 -64.798812 C 219.36675 -60.1035 215.558156 -56.294906 210.862844 -56.294906 C 206.167531 -56.294906 202.358938 -60.1035 202.358938 -64.798812 C 202.358938 -69.498031 206.167531 -73.302719 210.862844 -73.302719 C 215.558156 -73.302719 219.36675 -69.498031 219.36675 -64.798812 Z M 219.36675 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 223.30425 -41.1035 L 214.905813 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 253.382375 -64.798812 C 253.382375 -60.1035 249.573781 -56.294906 244.878469 -56.294906 C 240.183156 -56.294906 236.374563 -60.1035 236.374563 -64.798812 C 236.374563 -69.498031 240.183156 -73.302719 244.878469 -73.302719 C 249.573781 -73.302719 253.382375 -69.498031 253.382375 -64.798812 Z M 253.382375 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 232.437063 -41.1035 L 240.8355 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 236.374563 -105.705062 L 253.382375 -105.705062 L 253.382375 -88.69725 L 236.374563 -88.69725 Z M 236.374563 -105.705062 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 244.878469 -73.501937 L 244.878469 -88.19725 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph1-1" x="300.664" y="179.124"/>
</g>
<g clip-path="url(#clip1)" clip-rule="nonzero">
<path style="fill:none;stroke-width:1.59404;stroke-linecap:round;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-dasharray:0,3.1881;stroke-miterlimit:10;" d="M 244.878469 -106.201156 C 244.878469 -107.69725 247.714406 -108.443344 247.714406 -109.939437 C 247.714406 -111.021469 246.331594 -111.955062 244.878469 -112.927719 C 243.425344 -113.900375 242.042531 -114.833969 242.042531 -115.916 C 242.042531 -116.998031 243.425344 -117.931625 244.878469 -118.904281 C 246.331594 -119.880844 247.714406 -120.810531 247.714406 -121.892562 C 247.714406 -122.974594 246.331594 -123.908187 244.878469 -124.88475 C 243.425344 -125.857406 242.042531 -126.791 242.042531 -127.873031 C 242.042531 -129.365219 244.878469 -130.115219 244.878469 -131.607406 L 244.878469 -135.775375 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
</g>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 304.605469 168.796875 C 304.984375 166.777344 306.121094 163.5 307.445313 161.226563 L 301.765625 161.226563 C 303.089844 163.5 304.226563 166.777344 304.605469 168.796875 "/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 253.382375 -40.904281 L 270.390188 -40.904281 L 270.390188 -23.896469 L 253.382375 -23.896469 Z M 253.382375 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 261.886281 -8.705062 L 261.886281 -23.69725 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 287.398 -40.904281 L 304.405813 -40.904281 L 304.405813 -23.896469 L 287.398 -23.896469 Z M 287.398 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 268.187063 -6.001937 L 287.198781 -24.111312 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 287.398 -64.798812 C 287.398 -60.1035 283.593313 -56.294906 278.894094 -56.294906 C 274.198781 -56.294906 270.390188 -60.1035 270.390188 -64.798812 C 270.390188 -69.498031 274.198781 -73.302719 278.894094 -73.302719 C 283.593313 -73.302719 287.398 -69.498031 287.398 -64.798812 Z M 287.398 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 291.3355 -41.1035 L 282.940969 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 321.413625 -64.798812 C 321.413625 -60.1035 317.608938 -56.294906 312.909719 -56.294906 C 308.214406 -56.294906 304.405813 -60.1035 304.405813 -64.798812 C 304.405813 -69.498031 308.214406 -73.302719 312.909719 -73.302719 C 317.608938 -73.302719 321.413625 -69.498031 321.413625 -64.798812 Z M 321.413625 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 300.468313 -41.1035 L 308.86675 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 401.483938 -0.0019375 C 401.483938 4.697281 397.675344 8.505875 392.980031 8.505875 C 388.280813 8.505875 384.476125 4.697281 384.476125 -0.0019375 C 384.476125 -4.69725 388.280813 -8.505844 392.980031 -8.505844 C 397.675344 -8.505844 401.483938 -4.69725 401.483938 -0.0019375 Z M 401.483938 -0.0019375 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-18" x="408.995" y="11.837"/>
  <use xlink:href="#glyph0-12" x="416.676195" y="11.837"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-4" x="422.564116" y="11.837"/>
  <use xlink:href="#glyph0-19" x="428.452036" y="11.837"/>
  <use xlink:href="#glyph0-11" x="434.788275" y="11.837"/>
  <use xlink:href="#glyph0-20" x="440.347428" y="11.837"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-7" x="446.125759" y="11.837"/>
  <use xlink:href="#glyph0-11" x="452.461998" y="11.837"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-12" x="457.353655" y="11.837"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-21" x="463.241575" y="11.837"/>
  <use xlink:href="#glyph0-12" x="469.627627" y="11.837"/>
</g>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph0-5" x="475.067228" y="11.837"/>
  <use xlink:href="#glyph0-6" x="480.955149" y="11.837"/>
  <use xlink:href="#glyph0-7" x="483.963866" y="11.837"/>
  <use xlink:href="#glyph0-8" x="490.300105" y="11.837"/>
</g>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 350.4605 -40.904281 L 367.468313 -40.904281 L 367.468313 -23.896469 L 350.4605 -23.896469 Z M 350.4605 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.79701;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 383.0855 -9.423812 L 367.964406 -23.826156 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 446.1875 32.417969 C 445.007813 33.183594 442.847656 34.167969 441.097656 34.585938 L 443.777344 37.398438 C 444.277344 35.667969 445.367188 33.558594 446.1875 32.417969 "/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 350.4605 -64.798812 C 350.4605 -60.1035 346.651906 -56.294906 341.956594 -56.294906 C 337.257375 -56.294906 333.452688 -60.1035 333.452688 -64.798812 C 333.452688 -69.498031 337.257375 -73.302719 341.956594 -73.302719 C 346.651906 -73.302719 350.4605 -69.498031 350.4605 -64.798812 Z M 350.4605 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 354.237844 -41.404281 L 345.999563 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 384.476125 -64.798812 C 384.476125 -60.1035 380.667531 -56.294906 375.972219 -56.294906 C 371.273 -56.294906 367.468313 -60.1035 367.468313 -64.798812 C 367.468313 -69.498031 371.273 -73.302719 375.972219 -73.302719 C 380.667531 -73.302719 384.476125 -69.498031 384.476125 -64.798812 Z M 384.476125 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:1.19553;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 366.355031 -46.482406 L 371.788625 -56.830062 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 423.414063 67.613281 C 423.921875 69.265625 424.359375 72.15625 424.261719 74.367188 L 428.496094 72.144531 C 426.617188 70.96875 424.488281 68.96875 423.414063 67.613281 "/>
<path style="fill:none;stroke-width:0.99628;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 367.468313 -105.705062 L 384.476125 -105.705062 L 384.476125 -88.69725 L 367.468313 -88.69725 Z M 367.468313 -105.705062 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<g style="fill:rgb(0%,0%,0%);fill-opacity:1;">
  <use xlink:href="#glyph1-1" x="431.755" y="125.844"/>
</g>
<path style="fill:none;stroke-width:1.39478;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 375.972219 -80.080062 L 375.972219 -88.19725 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;" d="M 435.699219 100.011719 C 435.351563 101.871094 434.304688 104.894531 433.082031 106.984375 L 438.3125 106.984375 C 437.09375 104.894531 436.046875 101.871094 435.699219 100.011719 "/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 384.476125 -40.904281 L 401.483938 -40.904281 L 401.483938 -23.896469 L 384.476125 -23.896469 Z M 384.476125 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 392.980031 -9.001937 L 392.980031 -23.69725 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 418.49175 -40.904281 L 435.499563 -40.904281 L 435.499563 -23.896469 L 418.49175 -23.896469 Z M 418.49175 -40.904281 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 399.495656 -6.208969 L 418.292531 -24.111312 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 418.49175 -64.798812 C 418.49175 -60.1035 414.683156 -56.294906 409.987844 -56.294906 C 405.292531 -56.294906 401.483938 -60.1035 401.483938 -64.798812 C 401.483938 -69.498031 405.292531 -73.302719 409.987844 -73.302719 C 414.683156 -73.302719 418.49175 -69.498031 418.49175 -64.798812 Z M 418.49175 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 422.42925 -41.1035 L 414.030813 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
<g clip-path="url(#clip2)" clip-rule="nonzero">
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 452.507375 -64.798812 C 452.507375 -60.1035 448.698781 -56.294906 444.003469 -56.294906 C 439.308156 -56.294906 435.499563 -60.1035 435.499563 -64.798812 C 435.499563 -69.498031 439.308156 -73.302719 444.003469 -73.302719 C 448.698781 -73.302719 452.507375 -69.498031 452.507375 -64.798812 Z M 452.507375 -64.798812 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
</g>
<path style="fill:none;stroke-width:0.3985;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 431.562063 -41.1035 L 439.9605 -57.095687 " transform="matrix(1,0,0,-1,59.727,26.209)"/>
</g>
</svg>
"""

# ╔═╡ 548124bb-0229-40f3-ba57-e436f37612ec
@bind γ_mcts Slider(0:0.05:1, default=0.95, show_value=true)

# ╔═╡ 60644fcd-dec8-4e0e-bbee-2e29443e61c8
mcts_mdp = QuickMDP(GridWorld,
    states       = 𝒮,
    actions      = 𝒜,
    transition   = T,
    reward       = R,
    discount     = γ_mcts, # custom discount for visualization of MCTS policy
    initialstate = 𝒮,
    isterminal   = termination);

# ╔═╡ 7af62c0f-2154-4e0a-86bb-17dd3a84f362
md"First we create the MCTS solver with appropriate input parameters."

# ╔═╡ d69bb3f3-f805-40f8-8f19-6210246ff86c
mcts_solver = MCTSSolver(n_iterations=50,
	                     depth=20,
	                     exploration_constant=5.0,
                         enable_tree_vis=true);

# ╔═╡ 6467f4c6-a59f-4601-8b8e-5627e3386d0e
md"Then we solve the MDP to create a planner (again, we use \"planner\" instead of \"policy\" to indicate that the planner is executed online)."

# ╔═╡ e5143473-6471-43e4-ac20-2907968f35d3
mcts_planner = solve(mcts_solver, mcts_mdp);

# ╔═╡ 6b9b6f24-f4d4-435a-856a-469e5a20f602
md"We can sample a random initial state $s_0$, or pick a starting state."

# ╔═╡ 756cf1c4-ddfb-4173-8287-5eac419093ff
s₀ = State(4,2) # rand(initialstate(mcts_mdp))

# ╔═╡ 6befa3ba-35e8-4b03-a28b-b30ceb9a66d3
md"Similar to the `action` function which returns an action, MCTS also has an `action_info` function which—as the name suggests—returns the action and some information. We want to retrieve the `tree` from the `info` object."

# ╔═╡ 54e28d34-af2f-49df-95f4-d95ab9f6b3ea
aₘ, info = action_info(mcts_planner, s₀);

# ╔═╡ d156dbbd-a63d-48a8-8c15-664df10416f5
md"""
#### Online Tree Visualization
To visualize the online search tree, we can use `D3Trees.jl`.
"""

# ╔═╡ d4cee740-ab00-4078-b2b8-671cd155620a
md"We can control the labels for the state nodes—here we show the $(x,y)$ state and the reward."

# ╔═╡ 76d59916-c550-4d6e-b5c9-8989d67ad871
MCTS.node_tag(s::State) = "($(s.x), $(s.y))\nr = $(reward(mcts_mdp, s))"

# ╔═╡ dc03ec16-f319-4a98-a2ea-66ea5489151c
md"Click to expand the levels of the search tree. The root note is the initial state, and the layers alternate between states and actions."

# ╔═╡ 2af5a9a9-a612-44a6-8be0-1d6cc43fc200
tree = D3Tree(info[:tree], s₀, init_expand=1)

# ╔═╡ 6af23b44-528a-4027-9ba9-e1e91781d83b
md"""
## Simulations

Say we want to simulate many different episodes of the policies we created. `POMDPSimulators` provides this functionality.
"""

# ╔═╡ d613b978-98fa-44aa-ad1d-c51e50e2d12a
md"""
The `simulate` function performs the simulations given one of the simulators listed below.
```julia
simulate(sim::Simulator, m::MDP, p::Policy, s0=rand(initialstate(m)))
```
"""

# ╔═╡ 299dcfef-91d1-48c1-a163-830f340e31df
md"""
There are several simulators we can run, depending on the type of information we are looking for (see the [`POMDPSimulators`](https://juliapomdp.github.io/POMDPSimulators.jl/latest/which/) documentation for more details):
"""

# ╔═╡ 9f651d75-42c6-4a3e-ab88-6b6ed68a36ea
md"""
##### Fast rollout simulations and get the discounted reward [[docs](https://juliapomdp.github.io/POMDPSimulators.jl/latest/rollout/#Rollout)]:
```julia
simulator = RolloutSimulator()
```
"""

# ╔═╡ 15bce1e5-9078-438a-9659-d72cf3440b4e
md"""
##### Closely examime the histories (states, actions, rewards, etc.) [[docs](https://juliapomdp.github.io/POMDPSimulators.jl/latest/history_recorder/#History-Recorder)]:
```julia
simulator = HistoryRecorder()
```
"""

# ╔═╡ 273de0d6-aa6b-49c2-94e7-047879402ef9
md"""
##### Visualize a simulation [[docs](https://juliapomdp.github.io/POMDPSimulators.jl/latest/display/#Display)]:
```julia
simulator = DisplaySimulator()
```
"""

# ╔═╡ 144beb1b-3aec-4daa-a4f4-eb8274b1a009
md"""
##### Evaulate performance on many parallel Monte Carlo simulations [[docs](https://juliapomdp.github.io/POMDPSimulators.jl/latest/parallel/#Parallel)]:
```julia
run_parallel(queue::Vector{Sim})
```
"""

# ╔═╡ fdf3325d-a949-4f39-9067-77bb13ab8ba7
md"""
##### Interact with an environment from the perspective of the policy [[docs](https://juliapomdp.github.io/POMDPSimulators.jl/latest/sim/#sim-function)]:
```julia
sim(mdp, max_steps=100)
```
"""

# ╔═╡ 351a4e76-b13b-4719-9c86-097e0b10e930
md"""
##### Step through each individual simulation step [[docs](https://juliapomdp.github.io/POMDPSimulators.jl/latest/stepthrough/#Stepping-through)]:
```julia
stepthrough(mdp, policy, "s,a,r", max_steps=100)
```
"""

# ╔═╡ b26cc58b-c5ce-4660-889c-e6eb09577dd2
md"""
Here we use the `stepthrough` function to iterate over a simulation and inspect the state `s`, action `a`, and reward `r` at each time step.
"""

# ╔═╡ 06bf7a9e-2fc9-4c58-a1f2-b3bba9fce96f
md"""
Now lets collect a full simulation using `stepthrough` wrapped in `collect`.
"""

# ╔═╡ 908bd8f5-a523-43d9-ae83-7934ca93a226
md"""
### Animated GIF (Single Episode)
"""

# ╔═╡ 58c8c26f-21c9-4ef5-a0e0-712c9bd51150
md"Create GIF of single simulated episode? $(@bind create_episode_gif CheckBox())"

# ╔═╡ 4f13867a-a91e-4251-8d43-746baa6d12a6
isfile("gifs/gridworld_episode.gif") && LocalResource("./gifs/gridworld_episode.gif")

# ╔═╡ a0178751-85c0-4424-bfd0-4df86434855b
md"""
#### Rollout Simulator
We can "rollout" the policy for each algorithm above (e.g., _value iteration_, _Q-learning_, _SARSA_) and collect statistics on the quality of each policy through simulation.
"""

# ╔═╡ 0fdb2e3a-838c-435f-a152-f27ba2413a3b
rollsim = RolloutSimulator();

# ╔═╡ 680c3c05-2011-411e-87f1-7b27544cf8ea
md"""
Now we can simulate a single _episode_ (which picks a random initial state and follows the given policy until we hit a termination state). The return value of the `RolloutSimulator` is the _discounted reward_ (or _discounted return_) that the agent collected (meaning—in the Grid World problem—the final reward is discounted based on the chosen $\gamma$ where:

$$\begin{equation}
\text{discounted reward} = \sum_{t=1}^{\text{horizon}} \gamma^{t-1} r_t
\end{equation}$$

So if our first step ($t=1$) moves into a reward state (which are also terminal states by our Grid World definition), we would directly return that reward value (because $\gamma^0=1$). But if the agent "meanders" over time and then eventually lands in a reward state, our return value will be noticably discounted.
"""

# ╔═╡ 52ef9f86-2172-4600-9ddd-83f24fdc3944
md"""
Now we'll run $N_\text{sim}$ number of simulations—each representing a single episode—and collect the reward to compute some statistics.
"""

# ╔═╡ 8be067e6-e12d-4262-b3d7-368e17db8e93
md"""
Run large simulation: $(@bind show_simulation CheckBox())
"""

# ╔═╡ a4e1b417-60c9-475e-aa16-b2112f7b47cf
md"
## Custom Reward Color Scheme
We use the `ColorSchemes` package to define a custom red-to-green color scheme for cost-to-rewards."

# ╔═╡ 87710f14-a7ec-4983-b105-8090c4dd1463
cmap = ColorScheme([Colors.RGB(180/255, 0.0, 0.0), Colors.RGB(1, 1, 1), Colors.RGB(0.0, 100/255, 0.0)], "custom", "threetone, red, white, and green")

# ╔═╡ 25d170e9-1c26-4058-96fc-04ab47964b51
# plot the U values (maximum Q over the actions)
# x = row, y = column, z = U-value
function plot_grid_world(mdp::MDP,
        policy::Policy=NothingPolicy(),
        iter=0,
        discount=NaN;
        outline=true,
        show_policy=true,
        extra_title=isnan(discount) ? "" : " (iter=$iter, γ=$discount)",
        show_rewards=false,
		show_wind=false,
        outline_state::Union{State, Nothing}=nothing)
    
    gr()
	
    if policy isa NothingPolicy
        # override when the policy is empty
        show_policy = false
    end
    
    if iter == 0
        # solver has not been run yet, so we just plot the raw rewards
        # overwrite policy at time=0 to be emp
        U = get_rewards(mdp, policy)
    else
        # otherwise, use the Value Function to get the values (i.e., utility)
        U = values(mdp, policy)
    end

    # reshape to grid
    (xmax, ymax) = params.size
    Uxy = reshape(U, xmax, ymax)

	#println(typeof(Uxy[1]))
	if Uxy[1] isa Vector{Float32} #Matrix{Float64}
		#findmax(values(mdp, pi_mdp)[49])[1]
		Uxy = map(el -> findmax(el)[1], Uxy)
	end
	#print(typeof(Uxy[1]))


    # plot values (i.e the U matrix)
    fig = heatmap(Uxy',
                  legend=:none,
                  aspect_ratio=:equal,
                  framestyle=:box,
                  tickdirection=:out,
                  color=cmap.colors)
    xlims!(0.5, xmax+0.5)
    ylims!(0.5, ymax+0.5)
    xticks!(1:xmax)
    yticks!(1:ymax)

    rectangle(w, h, x, y) = Shape(x .+ [0,w,w,0], y .+ [0,0,h,h])
    
    if show_rewards
        for s in filter(s->reward(mdp, s) != 0, states(mdp))
		#for s in filter(s->0 != 0, states(mdp))
            r = reward(mdp, s)
            annotate!([(s.x, s.y, (r, :white, :center, 12, "Computer Modern"))])
        end
    end

	uq = Array{Float64}(undef,xmax,ymax)
	vq = Array{Float64}(undef,xmax,ymax)
    
    for x in 1:xmax, y in 1:ymax
        # display policy on the plot as arrows
        if show_policy
            grid = policy_grid(policy, xmax, ymax)
            annotate!([(x, y, (grid[x,y], :center, 12, "Computer Modern"))])
        end
        if outline
            rect = rectangle(1, 1, x - 0.5, y - 0.5)
            plot!(rect, fillalpha=0, linecolor=:gray)
        end
		if show_wind
			(wmag,wang) = params.wind_dict[State(x,y)]
	  		uq[x,y]=wmag * cos(wang)
			vq[x,y]=wmag * sin(wang)
		end 
    end

	if show_wind
		for xq=1:xmax
	 		yq= [1,2,3,4,5,6,7]
   			fig=quiver!(xq*[1,1,1,1,1,1,1], yq, quiver=(0.03*uq[xq,:],0.03*vq[xq,:]), 			c=:red)
		end
	end	

    if !isnothing(outline_state)
        terminal_states = filter(s->reward(mdp, s) != 0, states(mdp))
		terminal_states = filter(s->reward(mdp, s) != 0, states(mdp))
        color = (outline_state in terminal_states) ? "yellow" : "blue"
        rect = rectangle(1, 1, outline_state.x - 0.5, outline_state.y - 0.5)
        plot!(rect, fillalpha=0, linecolor=color)
    end

    title!("Grid World Policy Plot$extra_title")

    return fig
end

# ╔═╡ c85a316a-acd3-4aa3-8b65-28a332950240
render = plot_grid_world

# ╔═╡ 5af462ea-781b-4509-98de-c68c29ec81fd
mdp = QuickMDP(GridWorld,
    states       = 𝒮,
    actions      = 𝒜,
    transition   = T,
    reward       = R,
    discount     = γ,
    initialstate = 𝒮,
    isterminal   = termination,
	render       = render);

# ╔═╡ 8d683391-75eb-4f5d-8849-7dd77720b5bf
render(mdp, show_wind=true)

# ╔═╡ e67994b8-d519-4c24-9d61-5cbef1629baa
render(mdp; show_rewards=true)

# ╔═╡ 6a313110-dc93-4d50-a54a-ebd1dcc06ff6
mdp_soc = mdp

# ╔═╡ ba95fdd5-d643-4de2-8235-90e2b5651410
policy = solve(solver, mdp)

# ╔═╡ 4ef71be8-4768-4f58-bf31-78a895452617
render(mdp, policy, 30, γ; outline=true)

# ╔═╡ 32668e09-b12b-43c8-862f-b6f1a77557ec
one_based_policy!(policy) # change default initial policy from all zeros to all ones

# ╔═╡ 3b883115-7d45-4439-8d04-48df4684452f
aᵣ = action(policy, sᵣ)

# ╔═╡ 8e3c5337-951e-495c-a0e7-b050660d0192
value(policy, sᵣ)

# ╔═╡ 31116b95-3c7c-455e-8743-87b4b1988e62
typeof(policy)

# ╔═╡ 7ee1a2f0-0210-4e89-98e5-73f18fb178b1
begin
	_U = map(a->(a, value(policy, sᵣ, a), action(policy, sᵣ) == a), actions(mdp))
	Markdown.parse("""
\$s = ($(sᵣ.x), $(sᵣ.y))\\qquad a = \\text{$(action(policy, sᵣ))}\$

Action \$a \\in \\mathcal{A}\$   | Value from \$Q(s,a)\$  |  Selected from \$\\pi(s)\$
:------------------------------- | :------------------- | :----------
UP                               | $(_U[1][2])          | $(_U[1][3] ? true : "")
DOWN                             | $(_U[2][2])          | $(_U[2][3] ? true : "")
LEFT                             | $(_U[3][2])          | $(_U[3][3] ? true : "")
RIGHT                            | $(_U[4][2])          | $(_U[4][3] ? true : "")
""")
end

# ╔═╡ 9eba07a6-2753-42c5-8581-3fb7489c066a
distr = transition(mdp, sᵣ, aᵣ)

# ╔═╡ 6b77edd5-79d1-4b0a-b6e2-f8b83af52db7
U(π, s) = maximum(a->Q(π, s, a), actions(mdp)) # utility

# ╔═╡ e06f597d-dc01-4dea-b63a-5f61d49170e0
U(policy, sᵣ) == value(policy, sᵣ)

# ╔═╡ 70afdcab-1950-40c7-9517-dc0221c2582e
ssamp = rand(initialstate(mdp))

# ╔═╡ 4a7a3aec-848b-4400-9669-5271ab5bbb4e
(AbstractArray, rand(initialstate(mdp)), mdp)

# ╔═╡ b42c3f77-5536-4a78-85df-c46f7f98fe79
rand(initialstate(mdp))

# ╔═╡ f1491b8b-b27a-49ac-b7fa-64e9d33a3307
srand = rand(initialstate(mdp))

# ╔═╡ c15812cf-7ba9-4ac1-8590-b2025f68481d
mdp

# ╔═╡ 5775789d-9d4f-4a6b-9c08-980f762e5ed1
S_mdp = state_space(mdp)

# ╔═╡ abd3011d-a2c4-407b-9f8d-bf1b81c7c439
#A_mdp() = DiscreteNetwork(Chain(Dense(2, 32, relu), Dense(32, 8)), actions(mdp))
#A_mdp() = DiscreteNetwork(Chain(Dense(2, 28, relu), Dense(28, 49, relu), Dense(49, 8)), actions(mdp))
A_mdp() = DiscreteNetwork(Chain(Dense(2, 28, hardtanh), Dense(28, 49, hardtanh), Dense(49, 8)), actions(mdp))

# ╔═╡ ff85df53-b45c-4334-8722-4fd3b91c07f0
dqn_mdp = DQN(π=A_mdp(), S=S_mdp, N=100000)

# ╔═╡ 3e4d8886-6c4d-4a13-8841-e73c71a6baaf
plot_learning([dqn_mdp],
	title="DQN Learning Curve (SOC optimized MDP)",
	labels=["DQN"],
	legend=:right)

# ╔═╡ 1003a354-545c-48e0-a0e4-04a18bc9d739
directories(dqn_mdp)

# ╔═╡ 4efca3d3-d8f9-45f5-8eaf-c29b79cd6ab1
D = buffer_like(dqn_mdp.buffer, capacity=dqn_mdp.c_opt.batch_size, device=device(dqn_mdp.agent.π))

# ╔═╡ f9d49125-4686-4c4d-a3e5-c970edc6d347
D[:s]

# ╔═╡ 04783632-cab7-4e63-9e96-293830a36e1b
D[:a]

# ╔═╡ 05821112-e30a-427a-8d68-8fc4283832ea
D

# ╔═╡ 7289c3ea-c47d-438d-b4bb-8bac0681d0e4
max(0, dqn_mdp.buffer_init - length(dqn_mdp.buffer))

# ╔═╡ b164f6a3-a052-4393-b646-0666436cd315
dqn_mdp.log

# ╔═╡ b34618f6-8a30-41d4-bae1-aac2ede1cb30
isnothing(dqn_mdp.a_opt)

# ╔═╡ 0a88e3e8-bdea-4fde-9b22-a45fd590dbfa
dqn_mdp.agent.π

# ╔═╡ b666fe9b-f3c0-47f4-b801-5bef0ed72956
critic(dqn_mdp.agent.π)

# ╔═╡ c42fbe8d-415d-487b-af6b-7337b9855187
begin
	Q_2 = value(dqn_mdp.agent.π, D[:s], D[:a])
end

# ╔═╡ ec1dcd22-f6bc-4c30-b516-da6e48a07bd9
sum(value(dqn_mdp.agent.π, D[:s]) .* D[:a], dims=1)

# ╔═╡ 3844480d-5a06-4333-9147-f8818c05210f
value(dqn_mdp.agent.π, D[:s])

# ╔═╡ 2176c0c6-abd9-4ab9-8a54-069eb96bdf4b
dqn_mdp.buffer

# ╔═╡ e74d43c9-e6d9-4252-964a-743d92fcb75f
dqn_mdp.agent.π

# ╔═╡ 07b3a6e8-3424-4128-a212-4c93cc8fc2bf
dqn_mdp_time = DQN(π=A_mdp(), S=S_mdp, N=100000) #no difference, just a different copy to solve on the time-objective MDP

# ╔═╡ f001b2ea-54bf-41d2-aa93-a7b7d1a0d43b
plot_learning([dqn_mdp_time],
	title="DQN Learning Curve (Time optimized MDP)",
	labels=["DQN"],
	legend=:right)

# ╔═╡ bd59750e-77dd-4f4c-95cc-062524c96a61
actions(mdp)

# ╔═╡ bfd6313d-419d-4fdd-8a10-003ad6b2550c
pi_mdp = solve(dqn_mdp, mdp)

# ╔═╡ 844d62ef-1533-456b-ab15-46b3aafcbc91
action(pi_mdp, State(5, 3))

# ╔═╡ a104402f-27fb-4286-8108-e5e50e2fe49d
value(pi_mdp, State(2, 2))

# ╔═╡ 5409a4cd-8e86-4f64-b76d-42f3665ea7bf
value(pi_mdp, State(2, 2))[2]

# ╔═╡ 36e0c98d-853f-4c16-bb82-90da8491dcda
value(pi_mdp, State(1, 7))

# ╔═╡ 8dc5b52c-acf2-4251-8064-ef2e64ac53b4
#arrows[action(policy, s)]
typeof(action(pi_mdp, State(5, 3)))

# ╔═╡ ff39abfa-d0d1-4892-bc94-0491bbfb7d6f
begin
	println("Most likely SOC-optimized path:")
	path_record_soc = [(1,2)]
	for _ in 1:30
		(x, y) = path_record_soc[end]
		nextact = action(pi_mdp, State(x, y))[1]
		mode_succ = mode(T(State(x,y), nextact))
		println("from ($x, $y), moving $nextact most likely results in $mode_succ")
		#println(mode(T(State(x,y), nextact)))
		push!(path_record_soc, (mode_succ.x, mode_succ.y))
		if mode_succ == State(7, 1)
			break
		end
	end
	print(path_record_soc)
end

# ╔═╡ 4ccac89a-c7e9-4ff6-870e-95cef6ca8591
for x in 1:7
	for y in 1:7
		dqn_action = action(pi_mdp, State(x, y))[1]
		vi_action = action(vi_policy, State(x, y))
		if dqn_action != vi_action
			println("($x, $y): DQN action is $dqn_action, VI action is $vi_action")
		end
	end
end

# ╔═╡ 1eb8d0cb-8beb-4fde-bff0-df6b56b93900
typeof(pi_mdp)

# ╔═╡ 1f57f6bd-faaa-444c-9e72-8d05de70c9de
values(mdp, policy)

# ╔═╡ 00d91925-4942-4d53-8a23-c4800c051ea1
values(mdp, pi_mdp)

# ╔═╡ 50b9112c-a597-4e2b-86e0-70c6f2309a59
findmax(values(mdp, pi_mdp)[49])[1]

# ╔═╡ d2b8948b-c923-4812-b729-50f535782013
γ_2=Float32(discount(mdp))

# ╔═╡ fb9bcfb2-cf06-4f4f-abf6-0ac97d675883
s_solve = Sampler(mdp, dqn_mdp.agent, S=dqn_mdp.S, max_steps=dqn_mdp.max_steps, required_columns=extra_columns(dqn_mdp.buffer))

# ╔═╡ 08dcba85-27c8-4c59-9219-3cf498754553
isnothing(dqn_mdp.log.sampler) && (dqn_mdp.log.sampler = s_solve)

# ╔═╡ 8a0e5ddf-bbb3-420f-8abe-85a70f7bb284
data_steps = mdp_data(s_solve.S, s_solve.agent.space, dqn_mdp.ΔN, s_solve.required_columns)

# ╔═╡ 93541691-95b9-4b47-8404-2e506fe87f03
Crux.step!(data_steps, 1, s_solve, explore=true, i=dqn_mdp.i)

# ╔═╡ 50ce080c-235f-425a-925d-65f1c29e7d60
with_terminal() do
	for (s,a,r) in stepthrough(mdp, policy, "s,a,r", max_steps=100)
		@info "In state ($(s.x), $(s.y)), taking action $a, receiving reward $r"
	end
end		

# ╔═╡ bc474e19-7d3e-481c-b36c-e231cd72db94
steps = collect(stepthrough(mdp, policy, "s,a,r", max_steps=100))

# ╔═╡ 02f590b6-b034-4ac4-afd4-76bde37e68b6
md"Simulation time step: $(@bind t Slider(1:length(steps), default=1))"

# ╔═╡ 87c715e7-29aa-4111-a0d1-1c5049341142
simulate(rollsim, mdp, policy)

# ╔═╡ 7124f670-d5ba-4e9b-86cf-48f2be0bc2a2
if show_simulation
	using Statistics
	mean_std(X) = (μ=mean(X), σ=std(X), r=X)
	N_sim = 10_000

	stats_vi = mean_std([simulate(rollsim, mdp, policy) for _ in 1:N_sim])
	stats_ql = mean_std([simulate(rollsim, mdp, q_learning_policy) for _ in 1:N_sim])
	stats_sarsa = mean_std([simulate(rollsim, mdp, sarsa_policy) for _ in 1:N_sim])

	results = (value_iteration=stats_vi, q_learning=stats_ql, sarsa=stats_sarsa)
end

# ╔═╡ 92bb38e3-00e2-4d5b-a511-4f0580777aa5
if show_simulation
    using RollingFunctions
    using LaTeXStrings
    window = 500
    
    rolling_mean_vi = rolling(mean, results.value_iteration.r, window)
    rolling_mean_ql = rolling(mean, results.q_learning.r, window)
    rolling_mean_sarsa = rolling(mean, results.sarsa.r, window)
    rolling_error_vi = log.(rolling(std, results.value_iteration.r, window)/3)
    rolling_error_ql = log.(rolling(std, results.q_learning.r, window)/3)
    rolling_error_sarsa = log.(rolling(std, results.sarsa.r, window)/3)
    num_simulations = rolling(minimum, 1:N_sim, window)

    fig = plot(num_simulations, rolling_mean_vi,
		ribbon=rolling_error_vi, fillalpha=0.2,
        color="blue", label="Value iteration", legend=(0.8, 0.65))
    plot!(num_simulations, rolling_mean_ql,
		ribbon=rolling_error_ql, fillalpha=0.2,
        color="red", label="Q-learning")
    plot!(num_simulations, rolling_mean_sarsa,
		ribbon=rolling_error_sarsa, fillalpha=0.2,
        color="black", label="SARSA")

    xlabel!("number of simulations")
    ylabel!("mean reward")
    title!("Rolling Mean")
    xticks!(0:2000:N_sim, latexstring.(0:2000:N_sim))
    yticks!(1:6, latexstring.(1:6))
    fig
end

# ╔═╡ 459fc6a3-9353-47f0-a6c2-a978285865eb
mdp_time = QuickMDP(GridWorld, #MDP where minimizing completion time is the objective
    states       = 𝒮,
    actions      = 𝒜,
    transition   = T,
    reward       = (s, a=missing, s2=missing) -> R(s, a, s2, false),
    discount     = γ,
    initialstate = 𝒮,
    isterminal   = termination,
	render       = render);

# ╔═╡ b28e76ff-50c9-432b-a360-f432b9a2e14b
pi_mdp_time = solve(dqn_mdp_time, mdp_time)

# ╔═╡ fa153549-be92-452d-8391-6d3a21226d15
begin
	println("Most likely time-optimized path:")
	path_record_time = [(1,2)]
	for _ in 1:30
		(x, y) = path_record_time[end]
		nextact = action(pi_mdp_time, State(x, y))[1]
		mode_succ = mode(T(State(x,y), nextact))
		println("from ($x, $y), moving $nextact most likely results in $mode_succ")
		#println(mode(T(State(x,y), nextact)))
		push!(path_record_time, (mode_succ.x, mode_succ.y))
		if mode_succ == State(7, 1)
			break
		end
	end
	print(path_record_time)
end

# ╔═╡ c5fbf696-3e5c-4b59-be4d-9a43f30d6211
begin
	println("a")
	grid_plot = render(mdp, policy, 30; outline=false, outline_state=sᵣ)
	println("b")
	#distr_plot = plot_transition_probability(distr)
	println("c")
	#plot(grid_plot, distr_plot, layout=2)
	println("d")
end

# ╔═╡ 4bb93999-e6b5-4590-8605-9bfe83778890
viz = render(vi_mdp, vi_policy, vi_iterations, γ_vi, show_wind=true, show_rewards=true)

# ╔═╡ edc2ec3c-95d9-4079-9efe-a39ea2053e15
savefig(viz, "gridworld.svg")

# ╔═╡ 49cd3c8b-d633-40e7-99f4-57a948b53c92
function create_value_iteration_gif()
	frames = Frames(MIME("image/png"), fps=2)
	push!(frames, render(vi_mdp, NothingPolicy(), 0, γ_vi; outline=true))
	last_frame = nothing
	for iter in 0:21
		local_solver = ValueIterationSolver(max_iterations=iter)
		local_policy = solve(local_solver, vi_mdp)
		one_based_policy!(local_policy)
		last_frame = render(vi_mdp, local_policy, iter, γ_vi; outline=false)
		push!(frames, last_frame)
	end
	[push!(frames, last_frame) for _ in 1:10] # duplicate last frame
	!isdir("gifs") && mkdir("gifs") # create "gifs" directory
	write("gifs/gridworld_vi.gif", frames)
	LocalResource("./gifs/gridworld_vi.gif")
end

# ╔═╡ dfa19121-b929-467a-a4ab-3f6563f200cf
create_gif ? create_value_iteration_gif() : LocalResource("./gifs/gridworld_vi.gif")

# ╔═╡ ea27b654-d225-4708-bf3f-fab306f51c72
function create_discount_gif()
	frames_γ = Frames(MIME("image/png"), fps=2)
	last_frame_γ = nothing
	for γ_iter in 0:0.05:1
		local_solver = ValueIterationSolver(max_iterations=30)

		# local MDP to play around with γ
		vi_γ_mdp = QuickMDP(GridWorld,
			states       = 𝒮,
			actions      = 𝒜,
			transition   = T,
			reward       = R,
			discount     = γ_iter,
			initialstate = 𝒮,
			isterminal   = termination);

		local_π = solve(local_solver, vi_γ_mdp)
		one_based_policy!(local_π)
		last_frame_γ = render(vi_γ_mdp, local_π, 30, γ_iter; outline=false)
		push!(frames_γ, last_frame_γ)
	end
	[push!(frames_γ, last_frame_γ) for _ in 1:10] # duplicate last frame
	!isdir("gifs") && mkdir("gifs") # create "gifs" directory
	write("gifs/gridworld_vi_γ.gif", frames_γ)
	LocalResource("./gifs/gridworld_vi_γ.gif")
end

# ╔═╡ b0a444df-0b41-430b-924f-83075944368a
create_gif ? create_discount_gif() : LocalResource("./gifs/gridworld_vi_γ.gif")

# ╔═╡ ee5ae9e6-b837-4521-bac7-cf069765d278
render(mdp, q_learning_policy, n_episodes_q, γ)

# ╔═╡ fb0a10c6-ca0b-480c-93d6-09aac5cc96ed
render(mdp, sarsa_policy, n_episodes_sarsa, γ)

# ╔═╡ 54c013b4-6f96-4aa8-bd94-afed96b381b3
render(mdp, pi_mdp, 100000, γ; outline=true)

# ╔═╡ a590f77a-8a71-49c6-ac08-0c1c84106b81
render(mdp, pi_mdp_time, 100000, γ; outline=true)

# ╔═╡ caad8138-251b-4644-9217-3e3bba49e357
render(mdp, policy; outline_state=steps[t].s, outline=false)

# ╔═╡ 50121862-2d65-4f52-aa2f-69d23f8968e8
function create_simulated_episode_gif()
	sim_frames = Frames(MIME("image/png"), fps=2)
	for i in 1:length(steps)
		frame_i = render(mdp, policy;
			outline_state=steps[i].s, outline=false)
		push!(sim_frames, frame_i)
	end
	!isdir("gifs") && mkdir("gifs") # create "gifs" directory
	write("gifs/gridworld_episode.gif", sim_frames)
end

# ╔═╡ 0b6b147f-289c-466b-b859-e0b75f2d7823
create_episode_gif && create_simulated_episode_gif();

# ╔═╡ 92cdb96c-e636-4308-bf49-6d34246d3256
ColorScheme([get(cmap, i) for i in 0.0:0.001:1.0])

# ╔═╡ 228fb0a2-fa38-401d-9793-3e487f79d34d
md"""
## Latexify
Shout-out to Niklas Korsbo for the [`Latexify`](https://github.com/korsbo/Latexify.jl) package where we can print Julia expressions as LaTeX formated equations. Definitely not required for anything POMDPs related—just nice to have.
"""

# ╔═╡ e2d85e1d-3368-43b1-93db-d24023805b9f
@latexify Q(s,a) = Q(s,a) + α(r + γQ(s′, a′) - Q(s,a))

# ╔═╡ 9cc9137f-4585-43c9-b60d-2cd80d7766ff
md"""
## References
1. Maxim Egorov, Zachary N. Sunberg, Edward Balaban, Tim A. Wheeler, Jayesh K. Gupta, and Mykel J. Kochenderfer, "POMDPs.jl: A Framework for Sequential Decision Making under Uncertainty", *Journal of Machine Learning Research*, vol. 18, no. 26, pp. 1–5, 2017. [http://jmlr.org/papers/v18/16-300.html](http://jmlr.org/papers/v18/16-300.html)

2. Mykel J. Kochenderfer, Tim A. Wheeler, and Kyle H. Wray, "Algorithms for Decision Making", *MIT Press*, 2022. [https://algorithmsbook.com](https://algorithmsbook.com)

3. Christopher J. C. H. Watkins, "Learning from Delayed Rewards", *PhD Thesis*, University of Cambridge, Department of Engineering, 1989.

4. Gavin A. Rummery and Mahesan Niranjan, "On-Line Q-Learning Using Connectionist Systems", University of Cambridge, 1997, vol. 37.

5. Rémi Coulom, "Efficient Selectivity and Backup Operators in Monte-Carlo Tree Search", *International Conference on Computers and Games*, 2006.
"""

# ╔═╡ 9c139d5b-b8c9-4e00-ba5b-ee66fad73658
TableOfContents(title="Markov Decision Processes", depth=4)

# ╔═╡ aeec3109-1ebc-4edf-9ac5-eda3a30467cc
md"""
---
"""

# ╔═╡ 99f2318b-b1d2-4afa-960b-eed2971abede
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
# ╟─7ce1bec4-f238-407e-aefb-c633ee2fadd5
# ╠═db0265cd-ebe0-4bf2-9e70-c0f978b91ff6
# ╟─faf0ca6e-693d-4217-9e3c-e9e60339d416
# ╟─a84c5d59-ebc6-465e-8d92-87618b5712f0
# ╟─8d30248e-b3c3-4f37-8296-392898790283
# ╠═5e9b28a4-50b9-4c44-8d3c-48eb72bda3a5
# ╠═34582cc5-e9eb-4912-9caf-b516b4b9b221
# ╠═004510b7-64d1-47ed-b348-7161af733c01
# ╠═00f31771-a287-47b9-8adf-40c7d23bb7ea
# ╠═60ce9e30-6245-476b-be8d-838e29bc46f9
# ╠═3c4e8e72-015c-4ad4-b2de-ed1bb1eacc37
# ╠═4c0e7b16-b878-4a9f-a0cc-9448c311f015
# ╠═594c88f5-5e84-4abf-8218-f905fbf0e922
# ╠═e8ab064f-e58d-4006-abaa-05ebfc87df88
# ╠═e3be07a0-191e-4180-8e8f-02a07dd08352
# ╠═8477c27b-ea40-4c59-b1ca-da8b641eb884
# ╠═ae71c096-311f-4da5-8a6c-3829242af1f9
# ╠═d91bcc7c-0941-4d6c-b695-026c33f67329
# ╠═317f834a-0512-4f3a-9410-c08cd454e39b
# ╠═232d7d72-94f8-4dfe-abdf-2b6e712847f7
# ╠═5a39c469-bde9-47f1-aa7f-da2a381a4978
# ╠═ad255117-a3b8-4b66-b79b-8c5d0946053a
# ╠═e1850dbb-30ea-4e1e-94f7-10582f89fb5d
# ╠═43a7c406-3d59-4b80-8d34-7b6119e9c936
# ╠═176d21d2-e178-4622-b25c-9de72d675c59
# ╠═ddd669eb-bdaa-4db3-9781-ed22dc2f0655
# ╠═aad71f9f-bc67-4258-8a6c-260e63c40670
# ╠═1ac38756-c96a-4a92-9d17-3591057ee6b8
# ╠═373272eb-5274-4d77-befe-5ee799c99e1e
# ╠═081e74ee-8f52-4a9b-8be5-d0a3cbd46988
# ╠═89d5917d-86ee-44d2-8b0b-c84e9f01286d
# ╠═b440c44a-5261-41b9-b27b-65ee43af4ffe
# ╠═f72e8f9a-7d2e-4d36-ae6f-9f52a72d070e
# ╠═891d93cc-50bd-404e-8b8f-543287d2efd9
# ╠═feacb0c5-595f-465d-b40d-e05b2bb6c516
# ╠═efd79e16-190d-40a6-9987-a16465d1c70d
# ╠═c9811b7f-d076-42e7-9236-950a5f5051c3
# ╠═964ff5fa-444f-4095-9e2b-815dc4a68603
# ╠═52146c87-d7ab-4fae-b04e-e677d9235f53
# ╠═f9b07909-0df3-4eba-932d-4c19edf22106
# ╠═999cbb0a-76f1-4ba5-bf64-e34c4a424a3b
# ╠═46311cba-fd3d-455b-a928-1add57fc2fd0
# ╠═fbe10a2b-5217-4700-95ea-5ab666d62a3c
# ╠═7af3cb40-e49d-42c0-b87d-b898d1f27c1c
# ╠═629a2252-4d95-4d58-a004-96d491a26fcc
# ╠═8d5e27eb-8da3-45e9-8c0d-bcf42fc33959
# ╠═73d38b5c-c823-47ec-b5a0-12e84760cee7
# ╠═77388668-2419-410e-a384-f931fc375a5b
# ╠═ee2c3be5-2812-47d9-a4b1-36de5f34a4ca
# ╠═63b46029-c1c6-43b6-8782-30899b4af98c
# ╠═67faae61-5978-49b5-a1fa-5c0399c10312
# ╠═09770092-05c4-418b-b1ae-92b7fad1f6ad
# ╠═f217a555-54e2-4b2a-9d67-7e9340147325
# ╠═1f965ca7-8a36-4acf-a5d0-5e5b092ab6af
# ╠═25d170e9-1c26-4058-96fc-04ab47964b51
# ╠═52b96024-9f52-4f07-926b-2297ed7dd166
# ╠═d9755f26-3f30-48ba-91d7-266c0204237d
# ╟─e2a84ebf-a259-43c1-b512-f6c6b6e02d14
# ╠═c092511d-c2e7-4b8c-8104-b4b10893cb02
# ╠═13dbf845-14a7-4c98-a1db-b3a83c9ce37c
# ╠═8d683391-75eb-4f5d-8849-7dd77720b5bf
# ╟─31ae33aa-5f25-4cd8-8e63-8e77c2233208
# ╠═b83aceeb-4360-43ab-9396-ac57a9416791
# ╟─07846f69-2f7a-4e12-9f4b-6fed8659e9ed
# ╠═4a14aee4-12f1-4d55-9532-9b88e4c465f8
# ╟─99acb099-742c-4d13-abd8-c588217e4466
# ╟─581376af-21eb-4cc8-91af-7b671ebf4e71
# ╠═c1d07fca-1fbd-4450-96b1-c829d7ad8306
# ╟─dcfc1975-04e8-4d8e-ab46-d1e0846c071e
# ╠═bcc5e8a3-1e3a-40cf-a306-13599a4952ac
# ╠═90662948-8659-4892-b5b8-53188be05a8f
# ╟─d66edb3a-7ccc-4e75-8d42-8d5b1ff5afbb
# ╠═bc541507-61db-4084-9712-1c57d139e17f
# ╟─b2856919-5529-431b-8025-0b7f3f3081b0
# ╠═1303be2a-d18c-44b0-afb9-06a6b4ce5c08
# ╠═125d4f9f-748b-4354-83dc-6131b077e52b
# ╟─268e2bb2-e6e2-4198-ad83-a93fcfa65b80
# ╠═27e554ff-9861-4a41-ad65-9d5ae7727e45
# ╠═3712fb82-4aa4-41bf-a7a4-b61dfbf0c67d
# ╟─148d8e67-33a4-4065-911e-9ee0c33d8822
# ╠═49901c66-db64-48a2-b122-84d5f6b769db
# ╟─51796bfc-ee3c-4cab-9d58-359608fd4106
# ╠═f45a4ed7-c613-4e5c-8469-534860e365bc
# ╠═f7814a66-23c8-4782-ba06-755397af87db
# ╠═54d7926d-f8d0-4e95-9b29-5b3ce330ea04
# ╠═af9e2e9b-8d9c-4487-8c67-4e7d3ec4e304
# ╠═e67994b8-d519-4c24-9d61-5cbef1629baa
# ╟─e5286fa6-1a48-4020-ab03-c24a175c8c04
# ╠═87a6c45e-6f3e-428e-8301-3b0c4166a84b
# ╠═4ef71be8-4768-4f58-bf31-78a895452617
# ╟─fd5b8960-933a-4ca0-9a7e-5003821ccfe3
# ╠═6970821b-2b87-4e66-b737-512e83627998
# ╟─7c2c2733-eb28-4d85-9074-99e64074e414
# ╠═49b140ad-641f-436c-9492-cf3efbadd8d2
# ╠═5af462ea-781b-4509-98de-c68c29ec81fd
# ╠═6a313110-dc93-4d50-a54a-ebd1dcc06ff6
# ╠═459fc6a3-9353-47f0-a6c2-a978285865eb
# ╟─a3f76a77-bb6d-4a6b-8e5a-170dcc867c07
# ╟─9f5dc78e-8183-4a03-9282-1aebf1af218c
# ╠═142f0646-541e-453b-a3b1-4b8fadf709cc
# ╟─c67f7fc6-7af8-4e4f-a341-133c70f879bc
# ╠═48c966cb-6b79-42a6-8ff0-2fe3261f3981
# ╠═c6af3de1-1d91-4d5a-95a6-4baf9aca3c08
# ╠═12501ad4-b42d-4fc4-b54b-30f4b929c0ab
# ╠═ba95fdd5-d643-4de2-8235-90e2b5651410
# ╟─32668e09-b12b-43c8-862f-b6f1a77557ec
# ╟─90b507bd-8cab-4c30-816e-a4b264e903a6
# ╟─7ee1a2f0-0210-4e89-98e5-73f18fb178b1
# ╠═73182581-fdf4-4252-b64e-34f39e1f96da
# ╠═c5fbf696-3e5c-4b59-be4d-9a43f30d6211
# ╠═786b27eb-129f-4538-beca-7e8b69fd40e4
# ╠═9cb6e19b-25f4-44b5-8155-d55ad3ba617c
# ╠═da9926ae-4e49-4ff3-abc2-d8249bddb0f2
# ╠═9eba07a6-2753-42c5-8581-3fb7489c066a
# ╟─b942fd56-13c3-4729-a701-63f103b13638
# ╟─4de6845e-a555-4147-86e8-d623e399c22a
# ╠═3b883115-7d45-4439-8d04-48df4684452f
# ╟─887f90ce-98eb-4262-894b-e14a0a53fa50
# ╠═8e3c5337-951e-495c-a0e7-b050660d0192
# ╟─a4e4d65f-a734-404d-8478-029b0017651c
# ╟─73cde70f-17f9-4ccd-ae4e-0cf050c2915e
# ╠═6b77edd5-79d1-4b0a-b6e2-f8b83af52db7
# ╠═e06f597d-dc01-4dea-b63a-5f61d49170e0
# ╟─cd4d33c8-bc24-4327-a65e-ed2d46af766b
# ╠═c85a316a-acd3-4aa3-8b65-28a332950240
# ╟─d3b0aeb2-11c9-4d4e-aa53-bb831ccd74a2
# ╠═4d698cad-a570-4608-b6dd-20de5d7dbe33
# ╠═5024e6c5-39e2-4bd6-acca-05267cf8639e
# ╠═1540a649-b238-498e-a8fb-5a29461194b5
# ╠═1ae17bb4-35db-48fa-8b32-b8d669025160
# ╠═b5834c6a-687b-4b74-869c-6f01fa066fdb
# ╠═b9100f1b-4903-4edc-a371-2f4b0eb20298
# ╠═d63ff91c-42c9-410f-96f3-27277a6c4b35
# ╠═1adac9e9-9711-4ed7-b34b-979d272e6267
# ╟─6d024b5b-faa3-4075-babd-c6b260cef55e
# ╠═4bb93999-e6b5-4590-8605-9bfe83778890
# ╠═a8817d6e-2302-4f39-8b93-66d550ca09ef
# ╠═3590b4b0-5a05-4052-aa58-f48d3912ce77
# ╟─dd5e9a13-4297-4717-a150-e1908faea2ca
# ╠═edc2ec3c-95d9-4079-9efe-a39ea2053e15
# ╟─b4dd0437-b945-4b4e-a504-1ac0fca54a75
# ╟─38af3571-9b0a-4b19-b33a-573101b597a0
# ╟─49cd3c8b-d633-40e7-99f4-57a948b53c92
# ╠═dfa19121-b929-467a-a4ab-3f6563f200cf
# ╟─ea27b654-d225-4708-bf3f-fab306f51c72
# ╠═b0a444df-0b41-430b-924f-83075944368a
# ╟─a2b7e745-8b15-42c6-89ca-e97aef1c9a0f
# ╟─a94529cf-1ab3-4b28-887a-04be9d103869
# ╟─2d58ccfd-9b20-459a-a636-a47496df1b18
# ╟─f0725051-8770-47d5-b8a7-65b1ab0955dd
# ╠═10994f20-831d-4c63-ba4d-fe7e43347d5d
# ╠═9d1994d2-7ea9-4828-98fc-27bf5d17bab9
# ╟─acbaca80-cafb-49c3-adea-4fd507c2c142
# ╠═61e6ad96-ff2a-4dd9-9698-48c33bd43f26
# ╟─2db772d9-16a1-4bdb-9205-611a1921831f
# ╠═ee7c1fe5-2991-4b2a-981b-1c72106d5855
# ╠═ee5ae9e6-b837-4521-bac7-cf069765d278
# ╠═9cf0f694-d4a3-48fd-9cb0-1c8ac0361d5c
# ╠═bf23cf92-103f-4181-b9e6-97efe0249d0a
# ╠═1c1c765e-3a36-42f2-b1cb-8683b265ecad
# ╠═3bcf0923-8ac2-4f82-97ca-d0996658a046
# ╟─e8620cb9-21de-4e5d-805a-0571eeceef7d
# ╠═f73f735c-6e8a-4ad4-b404-9772ce557eb1
# ╟─c0929ea6-4b20-4e34-bec3-f0fc5935e406
# ╠═133eaaec-7113-4ec6-bac0-555f6efa1cb3
# ╠═fb0a10c6-ca0b-480c-93d6-09aac5cc96ed
# ╠═5bfbceb4-7006-47c0-a965-13500caef00d
# ╠═cabde5e8-a783-4c93-af0f-d9e0eee264ce
# ╠═b0d01d02-8d4e-41b4-9e0b-9c453f76aed2
# ╠═d313469b-8ff8-437b-b980-3643147ffedc
# ╠═70afdcab-1950-40c7-9517-dc0221c2582e
# ╠═4a7a3aec-848b-4400-9669-5271ab5bbb4e
# ╠═ebeb07a9-3ce5-4bc6-a5a3-6b9cc5db13a5
# ╠═0d469af2-ee02-45f6-a0f9-fcafbf57d6b8
# ╠═0e1876b6-be76-4c36-879f-0874cb294d86
# ╠═a6df6e0a-2e8f-4912-a7b8-e22595bcf867
# ╠═4bc5c35c-6d54-4ae8-82d6-cfec28cb437a
# ╠═a844f1ad-73c0-4423-b0f8-c1005d7ce932
# ╠═8678ffd0-9b3e-4d9a-bdc2-51488db4fe99
# ╠═b42c3f77-5536-4a78-85df-c46f7f98fe79
# ╠═ffba0c02-b49b-44ec-8e26-fbe0aba98fbe
# ╠═6798fa98-b54e-4025-ba55-c456ffe6c038
# ╠═65cc321c-85e4-47a7-9ba8-9c943dcf4426
# ╠═33eae184-86bd-4b0f-9547-7f5ba327a32e
# ╠═f1491b8b-b27a-49ac-b7fa-64e9d33a3307
# ╠═2009c8c9-bae0-40e3-a1be-7ec4e9a09d4d
# ╠═714a3736-cb91-4aae-844c-e458e885f7b8
# ╠═f5b900e6-dccb-4b4a-93ea-a80a717d65f9
# ╠═d83d0ab3-5f33-43f6-9700-1d63eee1f36b
# ╠═6efdc038-e234-4748-8efc-ef3372916cdf
# ╠═73c49153-3eb1-4ac7-8cb2-be72bd3b4a78
# ╠═0112328f-8cd9-472c-89d6-89a27c1b5740
# ╠═581e850c-4f89-4fb7-b674-c7be1b290de3
# ╠═c371c236-c5f8-46e0-86b3-a16592b65c69
# ╠═bd90f02a-99f3-4596-9063-b762cc6d4288
# ╠═793485d1-06ab-47ac-a30f-e969dbe60ff8
# ╠═6a2a16f7-ef76-4125-a452-01cfaec5212c
# ╠═56784563-c8bc-4b42-b0ae-d14c0bc6ef9f
# ╠═a5587b98-311b-48f9-b921-fd9e677f693f
# ╠═b7324c2f-7dd3-45a5-b5a0-a0f160d5b6fe
# ╠═2806c392-2f99-4751-8cd2-f8493a0a858a
# ╠═a8711617-3d6f-4465-bc72-ddf315bf187f
# ╠═9840980c-fff7-492f-9e31-8ca0a355edb4
# ╠═8a986284-5758-47a1-af46-caf1bf4c8b00
# ╠═01268c82-d479-47b7-9ae0-220cda895776
# ╠═677640fa-c0fd-49a3-b4d9-73a6c37b94fd
# ╠═116a84d2-4a8e-40e8-91fe-8dc65dfb12e7
# ╠═a9fff980-9e26-4389-bdb5-2a0dbebb2cd7
# ╠═83a089f2-4364-4f5e-959f-b7e1e6644749
# ╠═de7632bc-bfda-4972-8407-221f30943b72
# ╠═88ca10db-fb4e-4d35-ba82-6f70014d0a11
# ╠═1572f01a-5414-4b51-980b-9e248bb37186
# ╠═279d7550-ac70-4391-85ff-859aff6260d5
# ╠═b1c00123-0c78-43a8-8aad-0876d5bd0553
# ╠═31e06e7a-8d8d-431f-8879-23edd4f47390
# ╠═d26fd72c-b76d-48d7-820c-0aaf489f145b
# ╠═bd9c7106-bec7-4ac0-8004-c57a59c9123d
# ╠═9e5dddc2-5152-4d87-ada5-d9724ca8e1ba
# ╠═3d2fcda5-5a12-4a3a-ade5-ef010161a197
# ╠═9eee0130-13dd-42e4-ab63-80cd93f7b49b
# ╠═e8cc0f99-f846-4612-b6ba-00510d1e19ec
# ╠═c879f1fd-8c81-41b5-9704-1b52dd23fd82
# ╠═b378c854-a628-4048-8148-ccd5df02835a
# ╠═8bc6fabc-35c1-4de1-9fe8-23305fe4f723
# ╠═a496ec2c-c833-4e28-8f2c-d03ab3bbf72e
# ╠═93470482-a648-4189-995c-df9b85d96e8c
# ╠═f2bea74c-9222-456c-bfa7-8ce8e8e7fb69
# ╠═3ae03c36-877c-4be6-9ed3-37a5b7bac7f6
# ╠═c15812cf-7ba9-4ac1-8590-b2025f68481d
# ╠═5bc59e80-8892-4397-8952-0f11fc49441b
# ╠═5775789d-9d4f-4a6b-9c08-980f762e5ed1
# ╠═fecb5e93-7a12-425c-86f8-48d144040a5e
# ╠═abd3011d-a2c4-407b-9f8d-bf1b81c7c439
# ╠═bd59750e-77dd-4f4c-95cc-062524c96a61
# ╠═e1df43c7-1f3d-42b4-909c-a1c2b05381e3
# ╠═d3dc8b0b-2cda-4a61-b7e3-fd201c85d319
# ╠═942da32d-58f0-4057-88d8-b9077cc350e1
# ╠═eab76a21-9f55-4a1e-b01f-fce9d441c1eb
# ╠═ff85df53-b45c-4334-8722-4fd3b91c07f0
# ╠═07b3a6e8-3424-4128-a212-4c93cc8fc2bf
# ╠═44817047-1ed9-40bd-83e8-e8a2f72963a3
# ╠═bfd6313d-419d-4fdd-8a10-003ad6b2550c
# ╠═b28e76ff-50c9-432b-a360-f432b9a2e14b
# ╠═3e4d8886-6c4d-4a13-8841-e73c71a6baaf
# ╠═f001b2ea-54bf-41d2-aa93-a7b7d1a0d43b
# ╠═1003a354-545c-48e0-a0e4-04a18bc9d739
# ╠═844d62ef-1533-456b-ab15-46b3aafcbc91
# ╠═a104402f-27fb-4286-8108-e5e50e2fe49d
# ╠═5409a4cd-8e86-4f64-b76d-42f3665ea7bf
# ╠═36e0c98d-853f-4c16-bb82-90da8491dcda
# ╠═ed0577b6-e270-4f8c-87b1-417f52d3e8d3
# ╠═8dc5b52c-acf2-4251-8064-ef2e64ac53b4
# ╠═7621029b-0a9a-46ed-9da9-199a2b19ccd0
# ╠═54c013b4-6f96-4aa8-bd94-afed96b381b3
# ╠═a590f77a-8a71-49c6-ac08-0c1c84106b81
# ╠═ff39abfa-d0d1-4892-bc94-0491bbfb7d6f
# ╠═fa153549-be92-452d-8391-6d3a21226d15
# ╠═4ccac89a-c7e9-4ff6-870e-95cef6ca8591
# ╠═f687e004-aab2-4af5-b975-8a335c508c60
# ╠═1f57f6bd-faaa-444c-9e72-8d05de70c9de
# ╠═00d91925-4942-4d53-8a23-c4800c051ea1
# ╠═50b9112c-a597-4e2b-86e0-70c6f2309a59
# ╠═9224816f-b347-4aef-8d70-44a3800b636e
# ╠═31116b95-3c7c-455e-8743-87b4b1988e62
# ╠═1eb8d0cb-8beb-4fde-bff0-df6b56b93900
# ╠═4efca3d3-d8f9-45f5-8eaf-c29b79cd6ab1
# ╠═f85ee7b1-13df-42a3-a5f7-cc310552010a
# ╠═d2b8948b-c923-4812-b729-50f535782013
# ╠═fb9bcfb2-cf06-4f4f-abf6-0ac97d675883
# ╠═08dcba85-27c8-4c59-9219-3cf498754553
# ╠═7289c3ea-c47d-438d-b4bb-8bac0681d0e4
# ╠═b164f6a3-a052-4393-b646-0666436cd315
# ╠═b34618f6-8a30-41d4-bae1-aac2ede1cb30
# ╠═d96ae1e8-0638-441c-8c1f-1fd39be6611d
# ╠═0a88e3e8-bdea-4fde-9b22-a45fd590dbfa
# ╠═b666fe9b-f3c0-47f4-b801-5bef0ed72956
# ╠═6d8e4629-5122-4d19-a4ec-a4a7cf8ba8cc
# ╠═c42fbe8d-415d-487b-af6b-7337b9855187
# ╠═ec1dcd22-f6bc-4c30-b516-da6e48a07bd9
# ╠═3844480d-5a06-4333-9147-f8818c05210f
# ╠═2176c0c6-abd9-4ab9-8a54-069eb96bdf4b
# ╠═e74d43c9-e6d9-4252-964a-743d92fcb75f
# ╠═f9d49125-4686-4c4d-a3e5-c970edc6d347
# ╠═04783632-cab7-4e63-9e96-293830a36e1b
# ╠═05821112-e30a-427a-8d68-8fc4283832ea
# ╠═8a0e5ddf-bbb3-420f-8abe-85a70f7bb284
# ╠═93541691-95b9-4b47-8404-2e506fe87f03
# ╟─799026ed-92f0-439a-a7e3-bd362eb18b99
# ╟─3484668f-9cdb-4ac9-b683-8054f0ea9d7e
# ╟─105a8fb9-008c-4ae1-83e8-8894209ada0e
# ╠═548124bb-0229-40f3-ba57-e436f37612ec
# ╠═60644fcd-dec8-4e0e-bbee-2e29443e61c8
# ╟─7af62c0f-2154-4e0a-86bb-17dd3a84f362
# ╠═d69bb3f3-f805-40f8-8f19-6210246ff86c
# ╟─6467f4c6-a59f-4601-8b8e-5627e3386d0e
# ╠═e5143473-6471-43e4-ac20-2907968f35d3
# ╟─6b9b6f24-f4d4-435a-856a-469e5a20f602
# ╠═756cf1c4-ddfb-4173-8287-5eac419093ff
# ╟─6befa3ba-35e8-4b03-a28b-b30ceb9a66d3
# ╠═54e28d34-af2f-49df-95f4-d95ab9f6b3ea
# ╟─d156dbbd-a63d-48a8-8c15-664df10416f5
# ╟─d4cee740-ab00-4078-b2b8-671cd155620a
# ╠═76d59916-c550-4d6e-b5c9-8989d67ad871
# ╟─dc03ec16-f319-4a98-a2ea-66ea5489151c
# ╠═2af5a9a9-a612-44a6-8be0-1d6cc43fc200
# ╟─6af23b44-528a-4027-9ba9-e1e91781d83b
# ╠═6e6d983c-7cb3-4f85-ac0c-f1daf8ee3fee
# ╟─d613b978-98fa-44aa-ad1d-c51e50e2d12a
# ╟─299dcfef-91d1-48c1-a163-830f340e31df
# ╟─9f651d75-42c6-4a3e-ab88-6b6ed68a36ea
# ╟─15bce1e5-9078-438a-9659-d72cf3440b4e
# ╟─273de0d6-aa6b-49c2-94e7-047879402ef9
# ╟─144beb1b-3aec-4daa-a4f4-eb8274b1a009
# ╟─fdf3325d-a949-4f39-9067-77bb13ab8ba7
# ╟─351a4e76-b13b-4719-9c86-097e0b10e930
# ╟─b26cc58b-c5ce-4660-889c-e6eb09577dd2
# ╠═50ce080c-235f-425a-925d-65f1c29e7d60
# ╟─06bf7a9e-2fc9-4c58-a1f2-b3bba9fce96f
# ╠═bc474e19-7d3e-481c-b36c-e231cd72db94
# ╠═caad8138-251b-4644-9217-3e3bba49e357
# ╟─02f590b6-b034-4ac4-afd4-76bde37e68b6
# ╟─908bd8f5-a523-43d9-ae83-7934ca93a226
# ╟─58c8c26f-21c9-4ef5-a0e0-712c9bd51150
# ╟─50121862-2d65-4f52-aa2f-69d23f8968e8
# ╠═0b6b147f-289c-466b-b859-e0b75f2d7823
# ╠═4f13867a-a91e-4251-8d43-746baa6d12a6
# ╟─a0178751-85c0-4424-bfd0-4df86434855b
# ╠═0fdb2e3a-838c-435f-a152-f27ba2413a3b
# ╟─680c3c05-2011-411e-87f1-7b27544cf8ea
# ╠═87c715e7-29aa-4111-a0d1-1c5049341142
# ╟─52ef9f86-2172-4600-9ddd-83f24fdc3944
# ╟─8be067e6-e12d-4262-b3d7-368e17db8e93
# ╠═7124f670-d5ba-4e9b-86cf-48f2be0bc2a2
# ╠═92bb38e3-00e2-4d5b-a511-4f0580777aa5
# ╟─a4e1b417-60c9-475e-aa16-b2112f7b47cf
# ╠═87710f14-a7ec-4983-b105-8090c4dd1463
# ╠═92cdb96c-e636-4308-bf49-6d34246d3256
# ╟─228fb0a2-fa38-401d-9793-3e487f79d34d
# ╠═e2d85e1d-3368-43b1-93db-d24023805b9f
# ╟─9cc9137f-4585-43c9-b60d-2cd80d7766ff
# ╠═9c139d5b-b8c9-4e00-ba5b-ee66fad73658
# ╟─aeec3109-1ebc-4edf-9ac5-eda3a30467cc
# ╟─99f2318b-b1d2-4afa-960b-eed2971abede
