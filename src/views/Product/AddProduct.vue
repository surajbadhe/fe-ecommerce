<template>
  <div class="container mt-4">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <h4 class="text-center mb-3">Add New Product</h4>
        <form @submit.prevent="addProduct">
          <!-- Name -->
          <div class="form-group mb-3">
            <label for="name">Product Name</label>
            <input
                type="text"
                class="form-control"
                v-model="name"
                id="name"
                placeholder="Enter product name"
                required
            />
          </div>

          <!-- Description -->
          <div class="form-group mb-3">
            <label for="description">Description</label>
            <textarea
                class="form-control"
                v-model="description"
                id="description"
                placeholder="Enter product description"
                required
            ></textarea>
          </div>

          <!-- Price -->
          <div class="form-group mb-3">
            <label for="price">Price</label>
            <input
                type="number"
                class="form-control"
                v-model.number="price"
                id="price"
                placeholder="Enter price"
                required
            />
          </div>

          <!-- Image URL -->
          <div class="form-group mb-3">
            <label for="imageUrl">Image URL</label>
            <input
                type="url"
                class="form-control"
                v-model="imageUrl"
                id="imageUrl"
                placeholder="https://example.com/image.jpg"
            />
          </div>

          <!-- Category Dropdown -->
          <div class="form-group mb-3">
            <label for="category">Category</label>
            <select
                class="form-control"
                v-model.number="categoryId"
                id="category"
                required
            >
              <option value="" disabled>Select category</option>
              <option
                  v-for="cat in categories"
                  :key="cat.id"
                  :value="cat.id"
              >
                {{ cat.categoryName }}
              </option>
            </select>
          </div>

          <!-- Submit Button -->
          <button type="submit" class="btn btn-primary w-100">
            Add Product
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      name: "",
      description: "",
      price: null,
      imageUrl: "",
      categoryId: null,
      categories: [], // list of categories
      baseURL: "http://localhost:8080/products",
      categoryURL: "http://localhost:8080/categories/all"
    };
  },
  methods: {
    async fetchCategories() {
      try {
        const response = await axios.get(this.categoryURL);
        this.categories = response.data;
      } catch (err) {
        console.error("Error fetching categories:", err);
      }
    },
    async addProduct() {
      if (!this.name || !this.description || !this.price || !this.categoryId) {
        alert("Please fill all required fields!");
        return;
      }

      const newProduct = {
        name: this.name,
        description: this.description,
        price: this.price,
        imageUrl: this.imageUrl,
        categoryId: this.categoryId
      };

      try {
        await axios.post(this.baseURL, newProduct, {
          headers: { 'Content-Type': 'application/json' }
        });
        alert("✅ Product added successfully!");

        // Reset form
        Object.assign(this, { name: "", description: "", price: null, imageUrl: "", categoryId: null });
      } catch (err) {
        console.error("Failed to add product:", err);
        alert(`❌ Failed to add product: ${err.response?.data?.message || err.message}`);
      }
    }
  },
  mounted() {
    this.fetchCategories();
  }
};
</script>

<style scoped>
h4 {
  font-weight: 600;
}
</style>
