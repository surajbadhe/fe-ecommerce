<template>
  <div class="container mt-4">
    <h3 class="text-center mb-3">Products</h3>
    <table class="table table-bordered">
      <thead class="table-light">
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Image</th>
        <th>Category ID</th>
        <th>Category Name</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="product in products" :key="product.id">
        <td>{{ product.id }}</td>
        <td><input class="form-control" v-model="product.name"></td>
        <td><input class="form-control" v-model="product.description"></td>
        <td><input class="form-control" v-model.number="product.price"></td>
        <td><input class="form-control" v-model="product.imageUrl"></td>
        <td><input class="form-control" v-model.number="product.categoryId"></td>
        <td><input class="form-control" v-model.number="product.categoryName"></td>
        <td>
          <button class="btn btn-sm btn-success me-1" @click="updateProduct(product)">Update</button>
          <button class="btn btn-sm btn-danger" @click="deleteProduct(product.id)">Delete</button>
        </td>
      </tr>
      </tbody>
    </table>
    <div class="row mb-3">
      <div class="col-12 d-flex justify-content-between align-items-center">

        <router-link class="btn btn-success" to="/admin/product/add">Add Product</router-link>
      </div>
    </div>

  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      products: [],
      baseURL: "http://localhost:8080/products"
    };
  },
  mounted() {
    this.fetchProducts();
  },
  methods: {
    async fetchProducts() {
      try {
        const res = await axios.get(this.baseURL);
        this.products = res.data;
      } catch (err) {
        console.error(err);
      }
    },
    async updateProduct(product) {
      try {
        await axios.put(this.baseURL + "/" + product.id, product);
        alert("✅ Product updated successfully!");
      } catch (err) {
        console.error(err);
        alert("❌ Failed to update product.");
      }
    },
    async deleteProduct(id) {
      if (!confirm("Are you sure to delete?")) return;
      try {
        await axios.delete(this.baseURL + "/" + id);
        this.products = this.products.filter(p => p.id !== id);
        alert("✅ Product deleted successfully!");
      } catch (err) {
        console.error(err);
        alert("❌ Failed to delete product.");
      }
    }
  }
};
</script>
