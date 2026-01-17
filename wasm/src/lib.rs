use wasm_bindgen::prelude::*;
use js_sys::Date;

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

/// Hitung semua bilangan prima hingga n menggunakan Sieve of Eratosthenes
/// Algoritma O(n log log n) - sangat CPU intensive untuk n besar
#[wasm_bindgen]
pub fn calculate_primes(n: u32) -> Vec<u32> {
    if n < 2 {
        return vec![];
    }

    let mut is_prime = vec![true; (n + 1) as usize];
    is_prime[0] = false;
    is_prime[1] = false;

    let sqrt_n = (n as f64).sqrt() as u32;
    for i in 2..=sqrt_n {
        if is_prime[i as usize] {
            let mut j = i * i;
            while j <= n {
                is_prime[j as usize] = false;
                j += i;
            }
        }
    }

    is_prime
        .iter()
        .enumerate()
        .filter_map(|(idx, &prime)| if prime { Some(idx as u32) } else { None })
        .collect()
}

/// Generate Mandelbrot set untuk visualisasi fraktal
/// Computation heavy: nested loops dengan complex number operations
#[wasm_bindgen]
pub fn generate_mandelbrot(
    width: u32,
    height: u32,
    max_iterations: u32,
    zoom: f64,
    offset_x: f64,
    offset_y: f64,
) -> Vec<u8> {
    let mut data = vec![0u8; (width * height * 4) as usize];

    for py in 0..height {
        for px in 0..width {
            let x0 = (px as f64 / width as f64 - 0.5) * zoom + offset_x;
            let y0 = (py as f64 / height as f64 - 0.5) * zoom + offset_y;

            let mut x = 0.0;
            let mut y = 0.0;
            let mut iteration = 0;

            while x * x + y * y <= 4.0 && iteration < max_iterations {
                let xtemp = x * x - y * y + x0;
                y = 2.0 * x * y + y0;
                x = xtemp;
                iteration += 1;
            }

            let idx = ((py * width + px) * 4) as usize;
            
            if iteration == max_iterations {
                data[idx] = 0;
                data[idx + 1] = 0;
                data[idx + 2] = 0;
                data[idx + 3] = 255;
            } else {
                let color = (iteration as f64 / max_iterations as f64 * 255.0) as u8;
                data[idx] = color;
                data[idx + 1] = color / 2;
                data[idx + 2] = 255 - color;
                data[idx + 3] = 255;
            }
        }
    }

    data
}

/// Fibonacci dengan memoization - demonstrasi recursive computation
#[wasm_bindgen]
pub fn fibonacci(n: u32) -> u64 {
    if n <= 1 {
        return n as u64;
    }

    let mut prev = 0u64;
    let mut curr = 1u64;

    for _ in 2..=n {
        let next = prev + curr;
        prev = curr;
        curr = next;
    }

    curr
}

/// Sorting besar dengan quicksort - memory intensive operation
#[wasm_bindgen]
pub fn sort_large_array(mut arr: Vec<i32>) -> Vec<i32> {
    arr.sort_unstable();
    arr
}

/// String processing: count word frequency
#[wasm_bindgen]
pub fn analyze_text(text: &str) -> String {
    let words: Vec<&str> = text
        .split_whitespace()
        .collect();
    
    let word_count = words.len();
    let char_count = text.chars().count();
    let unique_words = {
        let mut unique = std::collections::HashSet::new();
        for word in &words {
            unique.insert(word.to_lowercase());
        }
        unique.len()
    };

    format!(
        "Words: {}, Chars: {}, Unique: {}",
        word_count, char_count, unique_words
    )
}

/// Benchmark helper untuk mengukur performance
#[wasm_bindgen]
pub fn benchmark_operation(operation: &str, size: u32) -> f64 {
    let start = Date::now();
    
    match operation {
        "primes" => {
            let _ = calculate_primes(size);
        }
        "fibonacci" => {
            let _ = fibonacci(size);
        }
        _ => {}
    }
    
    Date::now() - start
}