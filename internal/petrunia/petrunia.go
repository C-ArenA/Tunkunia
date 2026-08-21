package petrunia

// Net
//
// A Petri net R is defined by the tuple:
//
//	R = ⟨P, T, Pre, Post⟩
//
// where:
//
//	P = {p₁, p₂, ..., pₙ} is a set of places.
//	T = {t₁, t₂, ..., tₙ} is a set of transitions, with P ∩ T = ∅.
//	Pre  : P × T → ℕ is the pre-incidence function.
//	Post : P × T → ℕ is the post-incidence function.
//
// Pre(pᵢ, tⱼ) gives the weight associated with the arc pᵢ → tⱼ.
// Post(pᵢ, tⱼ) gives the weight associated with the arc tⱼ → pᵢ.
//
// Adapted from:
// Michel Diaz (ed.), Petri Nets: Fundamental Models, Verification and
// Applications. [diaz2009petri]
type Net struct {
	ID          int
	Places      []Place
	Transitions []Transition
	Colors      []Color

	// to maintain consistency, Pre and Post should be calculated from Places and Transitions positions
	Pre  [][]int // where Pre[i][j] gives the weight of arc pⱼ → tᵢ
	Post [][]int // where Post[i][j] gives the weight of arc tᵢ → pⱼ
}

type Place struct {
	ID int
}

type Transition struct {
	ID int
}

type Color struct {
	ID int
}

type Marking struct {
	ID          int
	NetID       int
	PlaceValues [][]int // where PlaceValues[i][j] gives the value of place pᵢ for color cⱼ
}
